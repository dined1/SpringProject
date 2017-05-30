drop schema test;
create schema test;
use test;

CREATE TABLE address (AddressId INTEGER NOT NULL AUTO_INCREMENT, AddressLine VARCHAR(255), City VARCHAR(255), Country VARCHAR(255), ModifiedDate VARCHAR(255), PostalCode VARCHAR(255), PRIMARY KEY (AddressId)) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE customer (CustomerId INTEGER NOT NULL AUTO_INCREMENT, Contact VARCHAR(255), Email VARCHAR(255), FirstName VARCHAR(255), LastName VARCHAR(255), Phone VARCHAR(255), PassNumber VARCHAR(255), CountNumber VARCHAR(255), ADDRESS1_AddressId INTEGER, UserId INTEGER, Username VARCHAR(255), location VARCHAR(255), PRIMARY KEY (CustomerId));
CREATE TABLE discountrule (DRId INTEGER NOT NULL AUTO_INCREMENT, DiscountProcent FLOAT, Discountvalue FLOAT, Type VARCHAR(255), Description VARCHAR(255), PRIMARY KEY (DRId));
CREATE TABLE groups (GroupId INTEGER NOT NULL AUTO_INCREMENT, Name VARCHAR(255) NOT NULL, PRIMARY KEY (GroupId));
CREATE TABLE location (locationId INTEGER NOT NULL AUTO_INCREMENT, Name VARCHAR(255) NOT NULL, customer_CustomerId INTEGER, address_addressId INTEGER, PRIMARY KEY (locationId));
CREATE TABLE relatedlocation (locationId INTEGER NOT NULL AUTO_INCREMENT, Name VARCHAR(255) NOT NULL, parentLocation_locationId INTEGER, customer_CustomerId INTEGER, PRIMARY KEY (locationId));
CREATE TABLE item (ItemId INTEGER NOT NULL AUTO_INCREMENT, DefMP FLOAT, DefOTP FLOAT, Description VARCHAR(255), ModifiedDate VARCHAR(255), Name VARCHAR(255), Type VARCHAR(255), quantity INTEGER, parent_itemId INTEGER, PRIMARY KEY (ItemId));
CREATE TABLE itemdiscount (IDid INTEGER NOT NULL AUTO_INCREMENT, DISCOUNTRULE1_DRId INTEGER, ITEM1_ItemId INTEGER, PRIMARY KEY (IDid));
CREATE TABLE itemgroup (IGId INTEGER NOT NULL AUTO_INCREMENT, GROUPS1_GroupId INTEGER, ITEM1_ItemId INTEGER, PRIMARY KEY (IGId));
CREATE TABLE paymentbill (PBId INTEGER NOT NULL AUTO_INCREMENT, CMPDisc FLOAT, COTPDisc FLOAT, CMP FLOAT, COTP FLOAT, PRIMARY KEY (PBId));
CREATE TABLE payment (PaymentId INTEGER NOT NULL AUTO_INCREMENT, PaymentInfo VARCHAR(255), PAYMENTBILL1_PBId INTEGER, PAYMENTTYPE1_PTId INTEGER, SO1_SOId BIGINT, paymentDate DATETIME, PRIMARY KEY (PaymentId));
CREATE TABLE paymenttype (PTId INTEGER NOT NULL AUTO_INCREMENT, TypeName VARCHAR(255), PRIMARY KEY (PTId)) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE PRODUCTITEMS (ID BIGINT NOT NULL AUTO_INCREMENT, ORDITEM_OrdItemId INTEGER, SOPRODUCT1_SOPId INTEGER, MP FLOAT, OTP FLOAT, MPWithTaxandDiscont float, OTPWithTaxandDiscont float, PRIMARY KEY (ID));
CREATE TABLE role (id int(11) NOT NULL AUTO_INCREMENT,  name varchar(45) DEFAULT NULL,  primary key (id)) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
CREATE TABLE so (SOId BIGINT NOT NULL AUTO_INCREMENT, DateCreated VARCHAR(255), DateModified VARCHAR(255), OrderDate VARCHAR(255), PurchaseOrderNumber VARCHAR(255)
, SONumber VARCHAR(255), Status VARCHAR(255), finalMP FLOAT, finalOTP FLOAT, finalMPwithTaxAndDiscount FLOAT, finalOTPwithTaxAndDiscount FLOAT, Location VARCHAR(255), attentionFlag varchar(255), CUSTOMER1_CustomerId INTEGER, USER1_UserId INTEGER, Location_locationId INTEGER, PRIMARY KEY (SOId));
CREATE TABLE soproduct (SOPId INTEGER NOT NULL AUTO_INCREMENT, SO1_SOId BIGINT, PRIMARY KEY (SOPId));
CREATE TABLE statisticscollector (SCId INTEGER NOT NULL AUTO_INCREMENT, StatisticType VARCHAR(255), StatisticsInfo VARCHAR(255), CUSTOMER1_CustomerId INTEGER, PRIMARY KEY (SCId));
CREATE TABLE user_role (user_id int(11) NOT NULL,  role_id int(11) NOT NULL,  PRIMARY KEY (user_id,role_id),  KEY fk_user_role_roleid_idx (role_id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE characteristics (CharacteristicId INTEGER NOT NULL AUTO_INCREMENT, Characteristic VARCHAR(255), Characteristicvalue VARCHAR(255), PRIMARY KEY (CharacteristicId));
CREATE TABLE itemcharacteristic (ItemCharacteristicId INTEGER NOT NULL AUTO_INCREMENT, ItemCharacteristic_CharacteristicId INTEGER, Item_itemId INTEGER, PRIMARY KEY (ItemCharacteristicId));
CREATE TABLE orditem (OrdItemId INTEGER NOT NULL AUTO_INCREMENT, DefMP FLOAT, DefOTP FLOAT, Description VARCHAR(255), ModifiedDate VARCHAR(255), Name VARCHAR(255), Type VARCHAR(255), locationDistribute VARCHAR(255), parentId INTEGER, location INTEGER, orderedBy INTEGER, initialVersion INTEGER, status varchar(255), parent_ordItemId INTEGER, PRIMARY KEY (OrdItemId));
CREATE TABLE orditemcharacteristic (OrdItemCharacteristicId INTEGER NOT NULL AUTO_INCREMENT, ItemCharacteristic_CharacteristicId INTEGER, OrdItem_orditemId INTEGER, PRIMARY KEY (OrdItemCharacteristicId));
CREATE TABLE orditemdiscount (OrdIDid INTEGER NOT NULL AUTO_INCREMENT, discountrule1_dRId INTEGER, OrdItem_orditemId INTEGER, PRIMARY KEY (OrdIDid));
CREATE TABLE locations (locationId INTEGER NOT NULL AUTO_INCREMENT, locationname varchar(255), PRIMARY KEY (locationId));
CREATE TABLE itemlocations (iLid INTEGER NOT NULL AUTO_INCREMENT, location_locationId INTEGER, item_ItemId INTEGER, PRIMARY KEY (iLid));


DROP TABLE IF EXISTS user;
CREATE TABLE user (id int(11) NOT NULL AUTO_INCREMENT,username varchar(255) DEFAULT NULL,password varchar(255) DEFAULT NULL, question varchar(255), answer varchar(255), PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

ALTER TABLE statisticscollector ADD CONSTRAINT FK_statisticscollector_CUSTOMER1_CustomerId FOREIGN KEY (CUSTOMER1_CustomerId) REFERENCES customer (CustomerId);
ALTER TABLE PRODUCTITEMS ADD CONSTRAINT FK_PRODUCTITEMS_ORDITEM_OrdItemId FOREIGN KEY (ORDITEM_OrdItemId) REFERENCES orditem (OrdItemId);
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
ALTER TABLE so ADD CONSTRAINT FK_so_Location_location FOREIGN KEY (Location_locationId) REFERENCES location (locationId);
ALTER TABLE soproduct ADD CONSTRAINT FK_soproduct_SO1_SOId FOREIGN KEY (SO1_SOId) REFERENCES so (SOId);
ALTER TABLE customer ADD CONSTRAINT FK_customer_ADDRESS1_AddressId FOREIGN KEY (ADDRESS1_AddressId) REFERENCES address (AddressId);
ALTER TABLE user_role ADD CONSTRAINT fk_user_role_roleid FOREIGN KEY (role_id) REFERENCES role (id);
ALTER TABLE user_role ADD CONSTRAINT fk_user_role_userid FOREIGN KEY (user_id) REFERENCES user (id);
ALTER TABLE itemcharacteristic ADD CONSTRAINT FK_itemcharacteristic_ITEM1_characteristic FOREIGN KEY (ItemCharacteristic_CharacteristicId) REFERENCES characteristics (CharacteristicId);
ALTER TABLE itemcharacteristic ADD CONSTRAINT FK_itemcharacteristic_ITEM1 FOREIGN KEY (Item_itemId) REFERENCES item (ItemId);
ALTER TABLE orditemcharacteristic ADD CONSTRAINT FK_orditemcharacteristic_ITEM1 FOREIGN KEY (OrdItem_orditemId) REFERENCES OrdItem (OrdItemId);
ALTER TABLE orditemcharacteristic ADD CONSTRAINT FK_orditemcharacteristic_ITEM1_characteristic FOREIGN KEY (ItemCharacteristic_CharacteristicId) REFERENCES characteristics (CharacteristicId);
ALTER TABLE orditemdiscount ADD CONSTRAINT FK_orditemdiscount_ITEM1_ItemId FOREIGN KEY (OrdItem_orditemId) REFERENCES orditem (OrdItemId);
ALTER TABLE orditemdiscount ADD CONSTRAINT FK_orditemdiscount_DISCOUNTRULE1_DRId FOREIGN KEY (discountrule1_dRId) REFERENCES discountrule (DRId);
ALTER TABLE itemlocations ADD CONSTRAINT FK_itemlocations_ITEM_ItemId FOREIGN KEY (item_ItemId) REFERENCES item (ItemId);
ALTER TABLE itemlocations ADD CONSTRAINT FK_itemlocations_location_locationId FOREIGN KEY (location_locationId) REFERENCES locations (locationId);
ALTER TABLE item ADD CONSTRAINT FK_parent_ITEM_ItemId FOREIGN KEY (parent_itemId) REFERENCES item (ItemId);
ALTER TABLE orditem ADD CONSTRAINT FK_parent_ORDITEM_OrdItemId FOREIGN KEY (parent_ordItemId) REFERENCES orditem (ordItemId);
ALTER TABLE location ADD CONSTRAINT FK_location_customer_CustomerId FOREIGN KEY (customer_CustomerId) REFERENCES customer (customerId);
ALTER TABLE location ADD CONSTRAINT FK_location_address_addressId FOREIGN KEY (address_addressId) REFERENCES address (addressId);
ALTER TABLE relatedlocation ADD CONSTRAINT FK_relatedlocation_parentLocation_locationId FOREIGN KEY (parentLocation_locationId) REFERENCES location (locationId);
ALTER TABLE relatedlocation ADD CONSTRAINT FK_relatedlocation_customer_CustomerId FOREIGN KEY (customer_CustomerId) REFERENCES customer (customerId);



insert into role values ('1', 'ROLE_USER');
insert into role values ('2', 'ROLE_ADMIN');
insert into role values ('3', 'ROLE_MODER');
insert into user values ('1', '12345678', '$2a$11$0ZKRrpHj6UE2oKkj8L4P4ezdpFAFJlziymTqyqlhlxdXJni7wt6/y', 'q', 'a');
insert into user values ('2', 'fragment', '$2a$11$zki2uF3twILG1noJJ8f9oubcrZ0KIadR4hvnexLHJ9QdPZ2zxpo2m', 'q', 'a');
insert into user values ('3', 'qwertyui', '$2a$11$qgZhVSDAsnl1vdlEGOQqbO0gP2nl4xdU2KDyXbr1jVOMQxMXzTWB6', 'q', 'a');
insert into address values('1', 'Parkovaya 9-15', 'Pinsk', 'Belarus', '06.11.2016', '234099');
insert into address values('2', 'Lesnaya 23-68', 'Moskow', 'Russia', '06.11.2016', '752834');
insert into address values('3', 'Sadovaya 2-16', 'St.Petersburg', 'Russia', '06.11.2016', '448645');
insert into address values('4', 'Stepnaya 34-61', 'Minsk', 'Belarus', '06.11.2016', '346734');
insert into address values('5', 'Novaya 34-61', 'Minsk', 'Belarus', '06.11.2016', '346734');
insert into address values('6', 'Vesennaya 34-61', 'Minsk', 'Belarus', '06.11.2016', '346734');
insert into address values('7', 'Slepanka 3-61', 'Moscow', 'Russia', '06.11.2016', '346734');



insert into item values ('1', '10000', '3000', 'This is internet', '08.11.2016', 'High Speed', 'Tech', '10', null);
insert into item values ('2', '1000', '500', 'This is internet', '04.11.2016', 'High Speed', 'Tech','39', null);
insert into item values ('3', '20000', '5000', 'This is internet', '05.09.2016', 'BestPlan1', 'Auto', '28', null);
insert into item values ('4', '30000', '3000', 'This is internet', '03.11.2016', 'BestPlan1', 'Auto', '65', null);
insert into item values ('5', '40000', '5000', 'This is internet', '12.12.2016', 'BestPlan1', 'Clothes', '56', null);
insert into item values ('6', '10000', '2000', 'This is internet', '23.11.2016', 'BestPlan1', 'Clothes', '3134', null);
insert into item values ('7', '30000', '1000', 'This is internet', '11.11.2016', 'BestPlan1', 'Sport', '124', null);
insert into item values ('8', '20000', '7000', 'This is internet', '05.01.2016', 'BestPlan1', 'Sport', '234', null);
insert into item values ('9', '70000', '8000', 'This is internet', '05.03.2016', 'BestPlan1', 'House', '12', null);
insert into item values ('10', '60000', '9000', 'This is internet', '05.11.2016', 'TV Pack', 'House', '575', null);
insert into item values ('11', '60000', '9000', 'This is internet', '05.11.2016', 'TV Pack', 'House', '575', null);
insert into item values ('12', '60000', '9000', 'This is internet', '05.11.2016', 'TV Pack', 'House', '575', null);

insert into discountrule values ('1', '0', '10', 'disc', 'Discount #1');
insert into discountrule values ('2', '20', '5', 'disc', 'Discount #2');
insert into discountrule values ('3', '30', '0', 'disc', 'Discount #3');
insert into discountrule values ('4', '15', '10', 'disc', 'Discount #4');
insert into discountrule values ('5', '70', '30', 'tax', 'Tax #1');
insert into discountrule values ('6', '40', '90', 'tax', 'Tax #2');
insert into itemdiscount values ('1', '1', '1');
insert into itemdiscount values ('2', '5', '1');
insert into itemdiscount values ('3', '3', '2');
insert into itemdiscount values ('4', '6', '2');
insert into itemdiscount values ('5', '3', '3');
insert into itemdiscount values ('6', '5', '3');
insert into itemdiscount values ('7', '1', '4');
insert into itemdiscount values ('8', '6', '4');
insert into itemdiscount values ('9', '4', '5');
insert into itemdiscount values ('10', '5', '5');
insert into itemdiscount values ('11', '1', '6');
insert into itemdiscount values ('12', '5', '6');
insert into itemdiscount values ('13', '3', '7');
insert into itemdiscount values ('14', '6', '7');
insert into itemdiscount values ('15', '3', '8');
insert into itemdiscount values ('16', '6', '8');
insert into itemdiscount values ('17', '1', '9');
insert into itemdiscount values ('18', '6', '9');
insert into itemdiscount values ('19', '4', '10');
insert into itemdiscount values ('20', '5', '10');

insert into groups values ('1', 'Tech');
insert into groups values ('2', 'Auto');
insert into groups values ('3', 'Clothes');
insert into groups values ('4', 'Sport');
insert into groups values ('5', 'House');
insert into itemgroup values ('1', '1', '1');
insert into itemgroup values ('2', '1', '2');
insert into itemgroup values ('3', '2', '3');
insert into itemgroup values ('4', '2', '4');
insert into itemgroup values ('5', '3', '5');
insert into itemgroup values ('6', '3', '6');
insert into itemgroup values ('7', '4', '7');
insert into itemgroup values ('8', '4', '8');
insert into itemgroup values ('9', '5', '9');
insert into itemgroup values ('10', '5', '10');

insert into paymentbill values ('1', '50', '1000', '3000',  '2000');
insert into paymentbill values ('2', '60', '1000', '1000',  '3000');
insert into paymentbill values ('3', '40', '1000', '2000',  '4000');
insert into paymentbill values ('4', '30', '1000', '4000',  '5000');
insert into paymenttype values ('1', 'Cash');
insert into paymenttype values ('2', 'Card');
insert into paymenttype values ('3', 'WEBPAY');
insert into paymenttype values ('4', 'ASSIST');
insert into paymenttype values ('5', 'WebMoney');
insert into user_role values ('1', '1');
insert into user_role values ('1', '2');
insert into user_role values ('1', '3');
insert into user_role values ('2', '1');
insert into user_role values ('3', '1');
insert into customer values ('1', '1111', 'Max@mail.com', 'Maxim', 'Karpik', '9701065', '234item325234', '2344234235', '1', '1','user', 'Belarus');
insert into customer values ('2', '1111', 'Max@com.ru', 'Maxim', 'User', '9701065', '234item325234', '2344234235', '1', '1','user', 'Belarus');
insert into customer values ('3', '1111', 'Cust1@com.ru', 'Customer2', 'User', '9701065', '234item325234', '2344234235', '2', '1','user', 'Belarus');
insert into customer values ('4', '1111', 'Cust2@com.ru', 'Customer3', 'User', '9701065', '234item325234', '2344234235', '3', '1','user',  'Belarus');
insert into customer values ('5', '1111', 'Cust3@com.ru', 'Customer4', 'User', '9701065', '234item325234', '2344234235', '4', '1','user',  'Belarus');
insert into customer values ('6', '1111', 'Cust4@com.ru', 'Customer5', 'User', '9701065', '234item325234', '2344234235', '5', '1','user',  'Belarus');
insert into customer values ('7', '1111', 'Cust5@com.ru', 'Customer6', 'User', '9701065', '234item325234', '2344234235', '6', '1','user',  'Belarus');
insert into customer values ('8', '1111', 'Cust6@com.ru', 'Customer7customer', 'User', '9701065', '234item325234', '2344234235', '3', '1','user',  'Belarus');

-- insert into customer values ('2', '2222', 'Vlad@com', 'Vladislav', 'Lukashevich', '1234567', '234325234', '2344234235', '2', '1', 'Belarus');
-- insert into customer values ('3', '3333', 'Lesha@com', 'Alexey', 'Pasevich', '8345281', '234325234', '2344234235', '3', '2', 'Belarus');
-- insert into customer values ('4', '4444', 'Dima@com', 'Dmitry', 'Nedavny', '4368532', '234325234', '2344234235', '4', '3', 'Belarus');
-- insert into statisticscollector values ('1', 'Type1', 'Info1', '1');
-- insert into statisticscollector values ('2', 'Type2', 'Info2', '2');
insert into locations values ('1', 'Belarus');
insert into locations values ('2', 'Russia');
insert into locations values ('3', 'Czech');
insert into locations values ('4', 'Slovakia');
insert into locations values ('5', 'Serbia');
insert into itemlocations values ('1', '1', '1');
insert into itemlocations values ('2', '1', '2');
insert into itemlocations values ('3', '2', '3');
insert into itemlocations values ('4', '2', '4');
insert into itemlocations values ('5', '3', '5');
insert into itemlocations values ('6', '3', '6');
insert into itemlocations values ('7', '4', '7');
insert into itemlocations values ('8', '4', '8');
insert into itemlocations values ('9', '5', '9');
insert into itemlocations values ('10', '5', '10');
insert into characteristics values ('1', 'Color', 'Red');
insert into characteristics values ('2', 'Color', 'Blue');
insert into characteristics values ('3', 'Color', 'Yellow');
insert into characteristics values ('4', 'Color', 'Green');
insert into characteristics values ('5', 'Color', 'Black');
insert into characteristics values ('6', 'Color', 'White');
insert into characteristics values ('7', 'Size', '40');
insert into characteristics values ('8', 'Size', '41');
insert into characteristics values ('9', 'Size', '42');
insert into characteristics values ('10', 'Size', '43');

/*insert into so values ('1', '05.11.2016', '04.11.2016', '08.11.2016', '011111', '1001', 'Ordered', '5', '5', '5', '5', 'Belarus', '1', '1');
insert into so values ('2', '05.11.2016', '08.11.2016', '', '022222', '1002', 'Wait', '5', '5', '5', '5', 'Belarus', '1', '1');
insert into so values ('3', '05.11.2016', '03.11.2016', '09.11.2016', '033333', '1003', 'Ordered', '5', '5', '5', '5', 'Belarus', '1', '1');

insert into soproduct values ('1', '1');
insert into soproduct values ('2', '2');
insert into soproduct values ('3', '3');

insert into PRODUCTITEMS values ('1', '1', '1', '1000', '1000');
insert into PRODUCTITEMS values ('2', '4', '1', '1000', '1000');
insert into PRODUCTITEMS values ('3', '5', '2', '1000', '1000');
insert into PRODUCTITEMS values ('4', '2', '2', '1000', '1000');
insert into PRODUCTITEMS values ('5', '8', '3', '1000', '1000');
insert into PRODUCTITEMS values ('6', '7', '3', '1000', '1000');*/











/*insert into so values ('1', '05.11.2016', '04.11.2016', '08.11.2016', '011111', '1001', 'Ordered', '5', '5', '5', '5', 'Belarus', '1', '1');
insert into so values ('2', '05.11.2016', '08.11.2016', '', '022222', '1002', 'Wait', '5', '5', '5', '5', 'Belarus', '1', '1');
insert into so values ('3', '05.11.2016', '03.11.2016', '09.11.2016', '033333', '1003', 'Ordered', '5', '5', '5', '5', 'Belarus', '1', '1');
insert into so values ('4', '05.11.2016', '02.11.2016', '', '044444', '1004', 'Wait', '5', '5', '5', '5', 'Belarus', '2', '2');
insert into so values ('5', '05.11.2016', '08.11.2016', '', '055555', '1005', 'Wait', '5', '5', '5', '5', 'Belarus', '2', '2');
insert into so values ('6', '05.11.2016', '06.11.2016', '07.11.2016', '066666', '1006', 'Ordered', '5', '5', '5', '5', 'Belarus', '2', '2');
insert into so values ('7', '05.11.2016', '08.11.2016', '', '077777', '1007', 'Wait', '5', '5', '5', '5', 'Belarus', '3', '3');
insert into so values ('8', '05.11.2016', '05.11.2016', '07.11.2016', '088888', '1008', 'Ordered', '5', '5', '5', '5', 'Belarus', '3', '3');
insert into so values ('9', '05.11.2016', '08.11.2016', '', '099999', '1009', 'Wait', '5', '5', '5', '5', 'Belarus', '3', '3');
insert into so values ('10', '05.11.2016', '03.11.2016', '06.11.2016', '100000', '1010', 'Ordered', '5', '5', '5', '5', 'Belarus', '4', '4');
insert into so values ('11', '05.11.2016', '08.11.2016', '', '111111', '1011', 'Wait', '5', '5', '5', '5', 'Belarus', '4', '4');
insert into so values ('12', '05.11.2016', '02.11.2016', '05.11.2016', '122222', '1012', 'Ordered', '5', '5', '5', '5', 'Belarus', '4', '4');

insert into soproduct values ('1', '1');
insert into soproduct values ('2', '2');
insert into soproduct values ('3', '3');
insert into soproduct values ('4', '4');
insert into soproduct values ('5', '5');
insert into soproduct values ('6', '6');
insert into soproduct values ('7', '7');
insert into soproduct values ('8', '8');
insert into soproduct values ('9', '9');
insert into soproduct values ('10', '10');
insert into soproduct values ('11', '11');
insert into soproduct values ('12', '12');

insert into PRODUCTITEMS values ('1', '1', '1', '1000', '1000');
insert into PRODUCTITEMS values ('2', '2', '2', '1000', '1000');
insert into PRODUCTITEMS values ('3', '3', '3', '1000', '1000');
insert into PRODUCTITEMS values ('4', '4', '4', '1000', '1000');
insert into PRODUCTITEMS values ('5', '5', '5', '1000', '1000');
insert into PRODUCTITEMS values ('6', '6', '6', '1000', '1000');
insert into PRODUCTITEMS values ('7', '7', '7', '1000', '1000');
insert into PRODUCTITEMS values ('8', '8', '8', '1000', '1000');
insert into PRODUCTITEMS values ('9', '9', '9', '1000', '1000');
insert into PRODUCTITEMS values ('10', '10', '10', '1000', '1000');
insert into PRODUCTITEMS values ('11', '1', '2', '1000', '1000');
insert into PRODUCTITEMS values ('12', '2', '3', '1000', '1000');
insert into PRODUCTITEMS values ('13', '3', '4', '1000', '1000');
insert into PRODUCTITEMS values ('14', '4', '5', '1000', '1000');
insert into PRODUCTITEMS values ('15', '5', '6', '1000', '1000');
insert into PRODUCTITEMS values ('16', '6', '7', '1000', '1000');
insert into PRODUCTITEMS values ('17', '7', '8', '1000', '1000');
insert into PRODUCTITEMS values ('18', '8', '9', '1000', '1000');
insert into PRODUCTITEMS values ('19', '9', '10', '1000', '1000');
insert into PRODUCTITEMS values ('20', '10', '1', '1000', '1000');
insert into PRODUCTITEMS values ('21', '1', '3', '1000', '1000');
insert into PRODUCTITEMS values ('22', '2', '4', '1000', '1000');
insert into PRODUCTITEMS values ('23', '3', '5', '1000', '1000');
insert into PRODUCTITEMS values ('24', '4', '6', '1000', '1000');
insert into PRODUCTITEMS values ('25', '5', '7', '1000', '1000');
insert into PRODUCTITEMS values ('26', '6', '8', '1000', '1000');
insert into PRODUCTITEMS values ('27', '7', '9', '1000', '1000');
insert into PRODUCTITEMS values ('28', '8', '10', '1000', '1000');
insert into PRODUCTITEMS values ('29', '9', '11', '1000', '1000');
insert into PRODUCTITEMS values ('30', '10', '12', '1000', '1000')*/























CREATE TABLE payusers (payuserid INTEGER NOT NULL AUTO_INCREMENT, login VARCHAR(255), password VARCHAR(255), first_name VARCHAR(255), last_name VARCHAR(255), email VARCHAR(255), registered date, enabled boolean, role varchar(255), KEY (payuserid)) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE accounts (accid INTEGER NOT NULL AUTO_INCREMENT, name VARCHAR(255), account_number VARCHAR(255), currency VARCHAR(255), balance decimal(20, 2), user_id integer, enabled boolean, PRIMARY KEY (accid));
CREATE TABLE account_histories (
  achisId INTEGER auto_increment PRIMARY KEY not null,
  from_user_id INTEGER NOT NULL,
  to_user_id INTEGER NOT NULL,
  from_account_id INTEGER NOT NULL,
  to_account_id INTEGER NOT NULL,
  operation_time TIMESTAMP,
  sender_currency VARCHAR(3) NOT NULL,
  recipient_currency VARCHAR(3) NOT NULL,
  from_account_number VARCHAR(255) NOT NULL,
  to_account_number VARCHAR(255) NOT NULL,
  comment VARCHAR(255) NOT NULL ,
  sender_amount DECIMAL(20,2) NOT NULL,
  recipient_amount DECIMAL(20,2) NOT NULL,
  commission DECIMAL(20,2) NOT NULL,
  amount_after_operation_on_sender DECIMAL(20,2) NOT NULL,
  amount_after_operation_in_recipient DECIMAL(20,2) NOT NULL
);
ALTER TABLE accounts ADD CONSTRAINT FK_accounts FOREIGN KEY (user_id) REFERENCES payusers (payuserid);
INSERT INTO `test`.`payusers` (`payuserid`, `login`, `password`, `first_name`, `last_name`, `email`, `registered`, `enabled`, `role`) VALUES ('1', '12345678', '12345678', '12213', 'asdasd', 'di@m.com', '2017-01-03', '1', 'ROLE_USER');
INSERT INTO `test`.`accounts` (`accid`, `name`, `account_number`, `currency`, `balance`, `user_id`, `enabled`) VALUES ('1', 'Account1', '000001', 'USD', '1000', '1', '1');
INSERT INTO `test`.`accounts` (`accid`, `name`, `account_number`, `currency`, `balance`, `user_id`, `enabled`) VALUES ('2', 'Account2', '000002', 'USD', '1000', '1', '1');