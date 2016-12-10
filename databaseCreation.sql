drop schema test;
create schema test;
use test;

CREATE TABLE address (
AddressId INTEGER NOT NULL,
AddressLine VARCHAR(255),
City VARCHAR(255),
Country VARCHAR(255),
ModifiedDate VARCHAR(255),
PostalCode VARCHAR(255),
PRIMARY KEY (AddressId)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE customer (CustomerId INTEGER NOT NULL AUTO_INCREMENT, Contact VARCHAR(255), Email VARCHAR(255), FirstName VARCHAR(255), LastName VARCHAR(255), Phone VARCHAR(255), PassNumber VARCHAR(255), CountNumber VARCHAR(255), ADDRESS1_AddressId INTEGER, PRIMARY KEY (CustomerId));
CREATE TABLE discountrule (DRId INTEGER NOT NULL AUTO_INCREMENT, DiscountProcent FLOAT, DiscountValue FLOAT, PRIMARY KEY (DRId));
CREATE TABLE groups (GroupId INTEGER NOT NULL AUTO_INCREMENT, Name VARCHAR(255) NOT NULL, PRIMARY KEY (GroupId));
CREATE TABLE item (ItemId INTEGER NOT NULL AUTO_INCREMENT, DefMP FLOAT, DefOTP FLOAT, Description VARCHAR(255), ModifiedDate VARCHAR(255), Name VARCHAR(255), Type VARCHAR(255), locationDistribute VARCHAR(255), PRIMARY KEY (ItemId));
CREATE TABLE itemdiscount (IDid INTEGER NOT NULL AUTO_INCREMENT, DISCOUNTRULE1_DRId INTEGER, ITEM1_ItemId INTEGER, PRIMARY KEY (IDid));
CREATE TABLE itemgroup (IGId INTEGER NOT NULL AUTO_INCREMENT, GROUPS1_GroupId INTEGER, ITEM1_ItemId INTEGER, PRIMARY KEY (IGId));
CREATE TABLE paymentbill (PBId INTEGER NOT NULL AUTO_INCREMENT, CMPDisc FLOAT, COTPDisc FLOAT, CMP FLOAT, COTP FLOAT, PRIMARY KEY (PBId));
CREATE TABLE payment (PaymentId INTEGER NOT NULL AUTO_INCREMENT, PaymentInfo VARCHAR(255), PAYMENTBILL1_PBId INTEGER, PAYMENTTYPE1_PTId INTEGER, SO1_SOId INTEGER, paymentDate DATE, PRIMARY KEY (PaymentId));
CREATE TABLE paymenttype (
PTId INTEGER NOT NULL,
TypeName VARCHAR(255),
PRIMARY KEY (PTId)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE PRODUCTITEMS (ID BIGINT NOT NULL AUTO_INCREMENT, ITEM1_ItemId INTEGER, SOPRODUCT1_SOPId INTEGER, PRIMARY KEY (ID));
CREATE TABLE role (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) DEFAULT NULL,
  primary key (id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
CREATE TABLE so (SOId INTEGER NOT NULL AUTO_INCREMENT, DateCreated VARCHAR(255), DateModified VARCHAR(255), OrderDate VARCHAR(255), PurchaseOrderNumber VARCHAR(255), SONumber VARCHAR(255), Status VARCHAR(255), CUSTOMER1_CustomerId INTEGER, USER1_UserId INTEGER, PRIMARY KEY (SOId));
CREATE TABLE soproduct (SOPId INTEGER NOT NULL AUTO_INCREMENT, MP FLOAT, OTP FLOAT, SO1_SOId INTEGER, PRIMARY KEY (SOPId));
CREATE TABLE statisticscollector (SCId INTEGER NOT NULL AUTO_INCREMENT, StatisticType VARCHAR(255), StatisticsInfo VARCHAR(255), CUSTOMER1_CustomerId INTEGER, PRIMARY KEY (SCId));
CREATE TABLE user_role (
  user_id int(11) NOT NULL,
  role_id int(11) NOT NULL,
  PRIMARY KEY (user_id,role_id),
  KEY fk_user_role_roleid_idx (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;






ALTER TABLE statisticscollector ADD CONSTRAINT FK_statisticscollector_CUSTOMER1_CustomerId FOREIGN KEY (CUSTOMER1_CustomerId) REFERENCES customer (CustomerId);
ALTER TABLE PRODUCTITEMS ADD CONSTRAINT FK_PRODUCTITEMS_ITEM1_ItemId FOREIGN KEY (ITEM1_ItemId) REFERENCES item (ItemId);
ALTER TABLE PRODUCTITEMS ADD CONSTRAINT FK_PRODUCTITEMS_SOPRODUCT1_SOPId FOREIGN KEY (SOPRODUCT1_SOPId) REFERENCES soproduct (SOPId);
ALTER TABLE itemdiscount ADD CONSTRAINT FK_itemdiscount_ITEM1_ItemId FOREIGN KEY (ITEM1_ItemId) REFERENCES item (ItemId);
ALTER TABLE itemdiscount ADD CONSTRAINT FK_itemdiscount_DISCOUNTRULE1_DRId FOREIGN KEY (DISCOUNTRULE1_DRId) REFERENCES discountrule (DRId);
ALTER TABLE payment ADD CONSTRAINT FK_payment_SO1_SOId FOREIGN KEY (SO1_SOId) REFERENCES so (SOId);
ALTER TABLE payment ADD CONSTRAINT FK_payment_PAYMENTTYPE1_PTId FOREIGN KEY (PAYMENTTYPE1_PTId) REFERENCES paymenttype (PTId);
ALTER TABLE payment ADD CONSTRAINT FK_payment_PAYMENTBILL1_PBId FOREIGN KEY (PAYMENTBILL1_PBId) REFERENCES paymentbill (PBId);
ALTER TABLE itemgroup ADD CONSTRAINT FK_itemgroup_GROUPS1_GroupId FOREIGN KEY (GROUPS1_GroupId) REFERENCES groups (GroupId);
ALTER TABLE itemgroup ADD CONSTRAINT FK_itemgroup_ITEM1_ItemId FOREIGN KEY (ITEM1_ItemId) REFERENCES item (ItemId);
ALTER TABLE so ADD CONSTRAINT FK_so_CUSTOMER1_CustomerId FOREIGN KEY (CUSTOMER1_CustomerId) REFERENCES customer (CustomerId);
ALTER TABLE so ADD CONSTRAINT FK_so_USER1_UserId FOREIGN KEY (USER1_UserId) REFERENCES user (id);
ALTER TABLE soproduct ADD CONSTRAINT FK_soproduct_SO1_SOId FOREIGN KEY (SO1_SOId) REFERENCES so (SOId);
ALTER TABLE customer ADD CONSTRAINT FK_customer_ADDRESS1_AddressId FOREIGN KEY (ADDRESS1_AddressId) REFERENCES address (AddressId);
ALTER TABLE user_role ADD CONSTRAINT fk_user_role_roleid FOREIGN KEY (role_id) REFERENCES role (id);
ALTER TABLE user_role ADD CONSTRAINT fk_user_role_userid FOREIGN KEY (user_id) REFERENCES user (id);


insert into role values ('1', 'ROLE_USER');
insert into user values ('1', 'AAAAAdm1', 'AAAAAdm1');
insert into user values ('2', 'MMMModer1', 'MMMModer1');
insert into user values ('3', 'MMMMMMax', 'MMMMMMax');
insert into user values ('4', 'VVVVVlad', 'VVVVVlad');
insert into user values ('5', 'LLLLesha', 'LLLLesha');
insert into user values ('6', 'DDDDDima', 'DDDDDima');
insert into user values ('7', '12345678', '$2a$11$0ZKRrpHj6UE2oKkj8L4P4ezdpFAFJlziymTqyqlhlxdXJni7wt6/y');
insert into address values('1', 'Parkovaya 9-15', 'Pinsk', 'Belarus', '06.11.2016', '234099');
insert into address values('2', 'Lesnaya 23-68', 'Moskow', 'Russia', '06.11.2016', '752834');
insert into address values('3', 'Sadovaya 2-16', 'St.Petersburg', 'Russia', '06.11.2016', '448645');
insert into address values('4', 'Stepnaya 34-61', 'Minsk', 'Belarus', '06.11.2016', '346734');
insert into groups values ('1', '353501');
insert into groups values ('2', '353502');
insert into groups values ('3', '353503');
insert into groups values ('4', '353504');
insert into groups values ('5', '353505');
insert into groups values ('6', '353506');
insert into groups values ('7', '353507');
insert into groups values ('8', '353508');
insert into groups values ('9', '353509');
insert into groups values ('10', '353510');
insert into groups values ('11', '353511');
insert into groups values ('12', '353512');
insert into groups values ('13', '353513');
insert into groups values ('14', '353514');
insert into groups values ('15', '353515');
insert into groups values ('16', '353516');
insert into groups values ('17', '353517');
insert into groups values ('18', '353518');
insert into groups values ('19', '353519');
insert into groups values ('20', '353520');
insert into item values ('1', '10000', '3000', 'Play Minecraft', '08.11.2016', 'Computer', 'Tech', 'Minsk');
insert into item values ('2', '1000', '500', 'Play Minecraft PE', '04.11.2016', 'Phone', 'Tech', 'Minsk');
insert into item values ('3', '20000', '5000', 'Drive', '05.09.2016', 'Car', 'Vehicle', 'Minsk');
insert into item values ('4', '30000', '3000', 'Fly', '03.11.2016', 'Pain 1', 'Pain', 'Minsk');
insert into item values ('5', '40000', '5000', 'Swim', '12.12.2016', 'Pain 2', 'Pain', 'Minsk');
insert into item values ('6', '10000', '2000', 'Kill', '23.11.2016', 'Suffering 1', 'Suffering', 'Minsk');
insert into item values ('7', '30000', '1000', 'Play Football', '11.11.2016', 'Suffering 2', 'Suffering', 'Minsk');
insert into item values ('8', '20000', '7000', 'Cut People', '05.01.2016', 'Olishevko 1', 'Olishevko', 'Minsk');
insert into item values ('9', '70000', '8000', 'Explode Cars', '05.03.2016', 'Olishevko 2', 'Olishevko', 'Minsk');
insert into item values ('10', '60000', '9000', 'Beat Women', '05.11.2016', 'Terror 1', 'Terror', 'Minsk');
insert into item values ('11', '50000', '5000', 'Shoot', '29.01.2016', 'Terror 2', 'Terror', 'Minsk');
insert into discountrule values ('1', '50', '1000');
insert into discountrule values ('2', '60', '2000');
insert into discountrule values ('3', '30', '8000');
insert into discountrule values ('4', '10', '6000');
insert into discountrule values ('5', '70', '3000');
insert into discountrule values ('6', '40', '9000');
insert into paymentbill values ('1', '50', '1000', '3000',  '2000');
insert into paymentbill values ('2', '60', '1000', '1000',  '3000');
insert into paymentbill values ('3', '40', '1000', '2000',  '4000');
insert into paymentbill values ('4', '30', '1000', '4000',  '5000');
insert into paymenttype values ('1', 'Cash');
insert into paymenttype values ('2', 'ERIP');
insert into paymenttype values ('3', 'WEBPAY');
insert into paymenttype values ('4', 'ASSIST');
insert into paymenttype values ('5', 'WebMoney');




insert into user_role values ('1', '1');
insert into user_role values ('2', '1');
insert into user_role values ('3', '1');
insert into user_role values ('7', '1');
insert into itemgroup values ('1', '1', '1');
insert into itemgroup values ('2', '2', '2');
insert into itemgroup values ('3', '3', '7');
insert into itemgroup values ('4', '4', '4');
insert into itemgroup values ('5', '5', '6');
insert into itemgroup values ('6', '4', '1');
insert into itemgroup values ('7', '1', '2');
insert into itemgroup values ('8', '2', '3');
insert into itemgroup values ('9', '5', '4');
insert into itemgroup values ('10', '3', '8');
insert into itemgroup values ('11', '5', '1');
insert into itemgroup values ('12', '3', '9');
insert into itemgroup values ('13', '1', '3');
insert into itemgroup values ('14', '2', '10');
insert into itemgroup values ('15', '4', '11');
insert into itemdiscount values ('1', '1', '5');
insert into itemdiscount values ('2', '2', '11');
insert into itemdiscount values ('3', '5', '6');
insert into itemdiscount values ('4', '6', '9');
insert into itemdiscount values ('5', '3', '4');
insert into itemdiscount values ('6', '2', '3');
insert into itemdiscount values ('7', '1', '7');
insert into itemdiscount values ('8', '6', '2');
insert into itemdiscount values ('9', '4', '10');
insert into itemdiscount values ('10', '2', '2');
insert into customer values ('1', '1111', 'Max@com', 'Maxim', 'Karpik', '9701065', '234325234', '2344234235', '1');
insert into customer values ('2', '2222', 'Vlad@com', 'Vladislav', 'Lukashevich', '1234567', '234325234', '2344234235', '2');
insert into customer values ('3', '3333', 'Lesha@com', 'Alexey', 'Pasevich', '8345281', '234325234', '2344234235', '3');
insert into customer values ('4', '4444', 'Dima@com', 'Dmitry', 'Nedavny', '4368532', '234325234', '2344234235', '4');
insert into so values ('1', '05.11.2016', '07.11.2016', '08.11.2016', '011111', '1001', 'Ordered', '1', '1');
insert into so values ('2', '05.11.2016', '07.11.2016', '08.11.2016', '022222', '1002', 'Ordered', '1', '1');
insert into so values ('3', '05.11.2016', '07.11.2016', '08.11.2016', '033333', '1003', 'Ordered', '1', '1');
insert into so values ('4', '05.11.2016', '07.11.2016', '08.11.2016', '044444', '1004', 'Ordered', '2', '2');
insert into so values ('5', '05.11.2016', '07.11.2016', '08.11.2016', '055555', '1005', 'Ordered', '2', '2');
insert into so values ('6', '05.11.2016', '07.11.2016', '08.11.2016', '066666', '1006', 'Ordered', '2', '2');
insert into so values ('7', '05.11.2016', '07.11.2016', '08.11.2016', '077777', '1007', 'Ordered', '3', '3');
insert into so values ('8', '05.11.2016', '07.11.2016', '08.11.2016', '088888', '1008', 'Ordered', '3', '3');
insert into so values ('9', '05.11.2016', '07.11.2016', '08.11.2016', '099999', '1009', 'Ordered', '3', '3');
insert into so values ('10', '05.11.2016', '07.11.2016', '08.11.2016', '100000', '1010', 'Ordered', '4', '4');
insert into so values ('11', '05.11.2016', '07.11.2016', '08.11.2016', '111111', '1011', 'Ordered', '4', '4');
insert into so values ('12', '05.11.2016', '07.11.2016', '08.11.2016', '122222', '1012', 'Ordered', '4', '4');
insert into soproduct values ('1', '1000', '2000', '1');
insert into soproduct values ('2', '1000', '2000', '2');
insert into soproduct values ('3', '1000', '2000', '3');
insert into soproduct values ('4', '1000', '2000', '4');
insert into soproduct values ('5', '1000', '2000', '5');
insert into soproduct values ('6', '1000', '2000', '6');
insert into soproduct values ('7', '1000', '2000', '7');
insert into soproduct values ('8', '1000', '2000', '8');
insert into soproduct values ('9', '1000', '2000', '9');
insert into soproduct values ('10', '1000', '2000', '10');
insert into soproduct values ('11', '1000', '2000', '11');
insert into soproduct values ('12', '1000', '2000', '12');
insert into payment values ('1', 'Info1', '1', '1', '1', '04.12.2016');
insert into payment values ('2', 'Info2', '2', '2', '2', '04.12.2016');
insert into payment values ('3', 'Info3', '3', '3', '2', '04.12.2016');
insert into payment values ('4', 'Info4', '4', '4', '3', '04.12.2016');
insert into payment values ('5', 'Info5', '1', '5', '4', '04.12.2016');
insert into payment values ('6', 'Info6', '2', '1', '2', '04.12.2016');
insert into payment values ('7', 'Info7', '3', '2', '3', '04.12.2016');
insert into payment values ('8', 'Info8', '4', '3', '2', '04.12.2016');
insert into payment values ('9', 'Info9', '1', '4', '1', '04.12.2016');
insert into payment values ('10', 'Info10', '2', '5', '3', '04.12.2016');
insert into payment values ('11', 'Info11', '3', '1', '4', '04.12.2016');
insert into payment values ('12', 'Info12', '4', '2', '3', '04.12.2016');
insert into statisticscollector values ('1', 'Type1', 'Info1', '1');
insert into statisticscollector values ('2', 'Type2', 'Info2', '2');
insert into PRODUCTITEMS values ('1', '1', '1');
insert into PRODUCTITEMS values ('2', '2', '2');
insert into PRODUCTITEMS values ('3', '3', '3');
insert into PRODUCTITEMS values ('4', '4', '4');
insert into PRODUCTITEMS values ('5', '5', '5');
insert into PRODUCTITEMS values ('6', '6', '6');
/*insert into PRODUCTITEMS values ('7', '7', '7');
insert into PRODUCTITEMS values ('8', '8', '8');
insert into PRODUCTITEMS values ('9', '9', '9');
insert into PRODUCTITEMS values ('10', '10', '10');
insert into PRODUCTITEMS values ('11', '1', '2');
insert into PRODUCTITEMS values ('12', '2', '3');
insert into PRODUCTITEMS values ('13', '3', '4');
insert into PRODUCTITEMS values ('14', '4', '5');
insert into PRODUCTITEMS values ('15', '5', '6');
insert into PRODUCTITEMS values ('16', '6', '7');
insert into PRODUCTITEMS values ('17', '7', '8');
insert into PRODUCTITEMS values ('18', '8', '9');
insert into PRODUCTITEMS values ('19', '9', '10');
insert into PRODUCTITEMS values ('20', '10', '1');
insert into PRODUCTITEMS values ('21', '1', '3');
insert into PRODUCTITEMS values ('22', '2', '4');
insert into PRODUCTITEMS values ('23', '3', '5');
insert into PRODUCTITEMS values ('24', '4', '6');
insert into PRODUCTITEMS values ('25', '5', '7');
insert into PRODUCTITEMS values ('26', '6', '8');
insert into PRODUCTITEMS values ('27', '7', '9');
insert into PRODUCTITEMS values ('28', '8', '10');
insert into PRODUCTITEMS values ('29', '9', '11');
insert into PRODUCTITEMS values ('30', '10', '12')*/















