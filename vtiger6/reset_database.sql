DELETE FROM mno_id_map;
DELETE FROM vtiger_activity;
DELETE FROM vtiger_account;
DELETE FROM vtiger_accountscf;
DELETE FROM vtiger_accountbillads;
DELETE FROM vtiger_accountshipads;
DELETE FROM vtiger_contactdetails;
DELETE FROM vtiger_contactaddress;
DELETE FROM vtiger_contactscf;
DELETE FROM vtiger_contactsubdetails;
DELETE FROM vtiger_customerdetails;
DELETE FROM vtiger_producttaxrel;
DELETE FROM vtiger_inventorytaxinfo;
DELETE FROM vtiger_inventorytaxinfo_seq;
INSERT INTO vtiger_inventorytaxinfo_seq (id) VALUES (1);
DELETE FROM vtiger_inventoryshippingrel;
DELETE FROM vtiger_inventorysubproductrel;
DELETE FROM vtiger_invoicebillads;
DELETE FROM vtiger_invoiceshipads;
DELETE FROM vtiger_products;
DELETE FROM vtiger_productcf;
DELETE FROM vtiger_service;
DELETE FROM vtiger_servicecf;
DELETE FROM vtiger_invoice;
DELETE FROM vtiger_invoicecf;
DELETE FROM vtiger_salesorder;
DELETE FROM vtiger_salesordercf;
DELETE FROM vtiger_crmentity;
DELETE FROM vtiger_crmentity_seq;
INSERT INTO vtiger_crmentity_seq (id) VALUES (1);
DELETE FROM vtiger_users WHERE id > 1;
DELETE FROM vtiger_crmentityrel;
DELETE FROM vtiger_senotesrel;
DELETE FROM vtiger_notes;
DELETE FROM vtiger_vendor;
DELETE FROM vtiger_vendorcf;
DELETE FROM vtiger_picklist WHERE picklistid IN (SELECT picklist_valueid FROM vtiger_glacct);
DELETE FROM vtiger_role2picklist WHERE picklistid IN (SELECT picklistid FROM vtiger_picklist WHERE name='glacct');
DELETE FROM vtiger_glacct;
DELETE FROM vtiger_field WHERE tablename='vtiger_inventoryproductrel' AND columnname LIKE 'tax%';
DELETE FROM vtiger_purchaseorder;
DELETE FROM vtiger_purchaseordercf;
DELETE FROM vtiger_pobillads;
DELETE FROM vtiger_poshipads;
DELETE FROM vtiger_quotes;
DELETE FROM vtiger_quotescf;
DELETE FROM vtiger_quotesbillads;
DELETE FROM vtiger_quotesshipads;
DELETE FROM vtiger_currency_info;

DROP TABLE IF EXISTS `vtiger_inventoryproductrel`;
CREATE TABLE `vtiger_inventoryproductrel` (
  `id` int(19) DEFAULT NULL,
  `productid` int(19) DEFAULT NULL,
  `sequence_no` int(4) DEFAULT NULL,
  `quantity` decimal(25,3) DEFAULT NULL,
  `listprice` decimal(27,8) DEFAULT NULL,
  `discount_percent` decimal(7,3) DEFAULT NULL,
  `discount_amount` decimal(27,8) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `description` text,
  `incrementondel` int(11) NOT NULL DEFAULT '0',
  `lineitem_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lineitem_id`),
  KEY `inventoryproductrel_id_idx` (`id`),
  KEY `inventoryproductrel_productid_idx` (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
