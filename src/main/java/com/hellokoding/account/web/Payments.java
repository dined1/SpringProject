package com.hellokoding.account.web;

import com.hellokoding.account.Models.Account;
import com.hellokoding.account.Models.Currency;
import com.hellokoding.account.Models.PayUser;
import com.hellokoding.account.Models.TransactionTransferObject;
import com.hellokoding.account.repository.AccountRepository;
import com.hellokoding.account.repository.PayUserrepository;
import com.hellokoding.account.service.CurrencyConverter;
import com.hellokoding.account.service.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.NoResultException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Context;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import static org.hibernate.jpa.internal.QueryImpl.LOG;

/**
 * Created by Admin on 02.01.2017.
 */
@RequestMapping(value = {"/payments"})
@Controller
@Transactional
public class Payments {

    @Autowired
    private PayUserrepository payUserrepository;
    @Autowired
    private AccountRepository accountRepository;


    @RequestMapping(value = {"/paylogin"}, method = RequestMethod.GET)
    public String payLogin(@Context HttpServletResponse httpServletResponse,
                           @Context HttpServletRequest httpServletRequest,
                           Model model) {
        for (Cookie cookie : httpServletRequest.getCookies()){
            cookie.setValue(null);
            cookie.setMaxAge(0);
            httpServletResponse.addCookie(cookie);
        }
        Cookie cookie = new Cookie("value", "12");
        httpServletResponse.addCookie(cookie);
        return "/paylogin";
    }


    @RequestMapping(value = {"/paylogin"}, method = RequestMethod.POST)
    public String payLoginpost(@Context HttpServletResponse httpServletResponse,
                               @Context HttpServletRequest httpServletRequest,
                               PayUser payUser, Model model) {
        if (payUserrepository.findByLoginAndPassword(payUser.getLogin(), payUser.getPassword()) != null){
            Cookie cookie = new Cookie("Login", payUser.getLogin());
            for (Cookie cookies : httpServletRequest.getCookies()){
                if (cookies.getName().equals("Login")){
                    cookies.setValue("");
                }
                httpServletResponse.addCookie(cookie);
            }
            httpServletResponse.addCookie(cookie);
            return "redirect:/payments/transfer";
        } else {
            return "redirect:/payments/paylogin";
        }

    }

    @RequestMapping(value = {"/transfer"}, method = RequestMethod.GET)
    public String proc(@Context HttpServletResponse httpServletResponse,
                       @Context HttpServletRequest httpServletRequest,
                       Model model) {
        String login = "";
        for (Cookie cookie : httpServletRequest.getCookies()){
            if (cookie.getName().equals("Login")){
                login = cookie.getValue();
            }
        }
        List<Account> accounts = accountRepository.findByUser_Login(login);
        model.addAttribute("Accounts", accounts);
        return "/accounts";
    }

    @RequestMapping(value = {"/payit"}, method = RequestMethod.GET)
    public String payIt(@Context HttpServletResponse httpServletResponse,
                        @Context HttpServletRequest httpServletRequest,
                        Model model, @RequestParam("accountnumber") String account) {
        String login = "";
        float summ = 0f;
        for (Cookie cookie : httpServletRequest.getCookies()){
            if (cookie.getName().equals("Login")){
                login = cookie.getValue();
            }
            if (cookie.getName().equals("value")){
                summ = Float.valueOf(cookie.getValue());
            }
        }
        List<Account> accounts = accountRepository.findByUser_Login(login);
        accountRepository.findAll();
        Account root = accountRepository.findOne(2L);
        TransactionTransferObject object = new TransactionTransferObject();
        for (Account acc : accounts){
            if (acc.getAccountNumber().equals(account)){
                if ((acc.getBalance().subtract(BigDecimal.valueOf(summ)).compareTo(BigDecimal.ZERO) !=-1 )){
                    object = getTransactionInformation(Integer.valueOf(String.valueOf(payUserrepository.findByLogin(login).getPayuserid())), Integer.valueOf(String.valueOf(acc.getAccid())), "Comment", root.getAccountNumber(), BigDecimal.valueOf(summ));
                }
            }
        }
        sendMoney(Integer.valueOf(String.valueOf(payUserrepository.findByLogin(login).getPayuserid())), Integer.valueOf(String.valueOf(object.getSenderAccount().getAccid())), 1,
                Integer.valueOf(String.valueOf(object.getRecipientAccount().getAccid())), object.getSenderCurrency(), object.getComment(),
                object.getAmount(), object.getCommission(), object.getAmountInRecipientCurrency());
        model.addAttribute("Accounts", accounts);
        for (Cookie cookie : httpServletRequest.getCookies()){
            cookie.setValue(null);
            cookie.setMaxAge(0);
            httpServletResponse.addCookie(cookie);
        }
        return "redirect:transfer";
    }


    public void sendMoney(int senderId, int senderAccountId,
                          int recipientId, int recipientAccountId,
                          Currency currency, String comment,
                          BigDecimal transferAmount, BigDecimal commission, BigDecimal amountForReceive) {
        LOG.info("send money from user id=" + senderId + " to id=" + recipientId + ". " +
                "From account id=" + senderAccountId + " to id=" + recipientAccountId);
        sendMoneyto(
                senderId, senderAccountId,
                recipientId, recipientAccountId,
                currency, comment,
                transferAmount, commission, amountForReceive);
    }

    @Transactional
    public void sendMoneyto(int senderUserId, int senderAccountId,
                          int recipientUserId, int recipientAccountId,
                          Currency senderCurrency, String comment,
                          BigDecimal amountSender, BigDecimal commission, BigDecimal amountRecipient) {
        //withdraw money from sender account
        Account senderAccount = withdrawMoneyFromAccount(senderUserId, senderAccountId, amountSender);

        //put money to recipient account
        Account recipientAccount = putMoneyIntoAccount(recipientUserId, recipientAccountId, amountRecipient);

    }

    public static BigDecimal addMoney(BigDecimal balance, BigDecimal amount) {
        return balance.add(amount).setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    @Transactional
    public Account putMoneyIntoAccount(int userId, int accountId, BigDecimal amount) {
        Account account = get(accountId);
        ExceptionUtils.checkAccountForBlocking(account);
        account.setBalance(addMoney(account.getBalance(), amount));
        return save(account, userId);
    }

    public Account withdrawMoneyFromAccount(int userId, int accountId, BigDecimal amount) {
        Account account = get(accountId);
        account.setBalance(withdrawMoney(account.getBalance(), amount));
        return save(account, userId);
    }

    @Transactional
    public Account save(Account account, int userId) {
        Account createdAccount = accountRepository.save(account);
        return createdAccount;
    }

    public TransactionTransferObject getTransactionInformation(int userId, int accountId, String comment,
                                                               String recipientAccountNumber, BigDecimal amount) {
        checkingAccountExistence(recipientAccountNumber);
        checkingAccountBalance(userId, accountId, amount);

        Account sender = get(accountId);
        Account recipient = accountRepository.findByAccountNumber(recipientAccountNumber);

        ExceptionUtils.checkAccountForBlocking(recipient);

        Currency senderCurrency = sender.getCurrency();
        Currency recipientCurrency = recipient.getCurrency();

        List<BigDecimal> commissionAndRecipientAmount = countCommissionRate(amount);
        BigDecimal recipientAmount = commissionAndRecipientAmount.get(0);
        BigDecimal commission = commissionAndRecipientAmount.get(1);

        if (!senderCurrency.equals(recipientCurrency)) {
            recipientAmount = CurrencyConverter.convertMoney(senderCurrency, recipientCurrency, recipientAmount);
        }
        return new TransactionTransferObject(sender, recipient, comment, amount, commission, recipientAmount);
    }

    public static List<BigDecimal> countCommissionRate(BigDecimal amount) {
        List<BigDecimal> result = new ArrayList<>();
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        double commissionRate = 0.01;
        BigDecimal commission = amount.multiply(new BigDecimal(commissionRate));
        commission = commission.setScale(2, BigDecimal.ROUND_HALF_UP);
        BigDecimal balance = withdrawMoney(amount, commission);
        result.add(balance);
        result.add(commission);
        return result;
    }
    public static BigDecimal withdrawMoney(BigDecimal balance, BigDecimal amount) {
        return balance.subtract(amount).setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    public void checkingAccountExistence(String accountNumber) {
        try {
            accountRepository.findByAccountNumber(accountNumber);
        } catch(NoResultException e) {
            throw new RuntimeException();
        }

    }

    public void checkingAccountBalance(int userId, int accountId, BigDecimal amount) {
        ExceptionUtils.checkBalance(get(accountId).getBalance(), amount);
    }

    public Account get(int accountId) {
        return accountRepository.findOne((long) accountId);
    }
}
