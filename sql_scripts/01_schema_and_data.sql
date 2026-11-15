-- =====================================================================
--  PHARMACY WAREHOUSE
-- =====================================================================
drop table sale;       -- FK -> medicine
drop table purchase;   -- FK -> medicine, supplier
drop table medicine;   -- FK -> category
drop table supplier;
drop table category;

-- ---------- 1. CATEGORY ----------
create table category
(
  categoryid          number primary key,
  categoryname        varchar2(50)  not null,
  categorydescription varchar2(200) not null
);
 
insert into category values (1, 'Antibiotics',   'Drugs used against bacterial infections');
insert into category values (2, 'Painkillers',   'Pain relief and fever reducing drugs');
insert into category values (3, 'Vitamins',      'Vitamin and mineral supplements');
insert into category values (4, 'Dermatology',   'Skin care and treatment products');
insert into category values (5, 'Kids Products', 'Medicines and supplements for children');
 
-- ---------- 2. SUPPLIER ----------
create table supplier
(
  supplierid      number primary key,
  suppliername    varchar2(50)  not null,
  supplieraddress varchar2(200) not null,
  supplierphone   varchar2(20)  not null
);
 
insert into supplier values (1, 'AzFarm LLC',      'Baku, Nizami Street 12',   '012-555-1010');
insert into supplier values (2, 'MediPlus LLC',    'Baku, Fizuli Street 44',   '012-555-2020');
insert into supplier values (3, 'Global Pharma',   'Sumgayit, Vurgun St. 7',   '018-555-3030');
insert into supplier values (4, 'Zafar Warehouse', 'Ganja, Ataturk Avenue 91', '022-555-4040');
 
-- ---------- 3. MEDICINE ----------
create table medicine
(
  medicineid          number primary key,
  medicinename        varchar2(50)  not null,
  medicinedescription varchar2(200) not null,
  categoryid          number        not null,
  price               number(10,2)  not null,
  quantityinstock     number        not null,
  foreign key (categoryid) references category(categoryid)
);
 
insert into medicine values (1,  'Amoxicillin 500',    'Broad spectrum antibiotic',        1, 12.50, 120);
insert into medicine values (2,  'Azithromycin 250',   'For respiratory tract infections', 1, 18.90,  60);
insert into medicine values (3,  'Paracetamol 500',    'Fever reducer and painkiller',     2,  3.40, 400);
insert into medicine values (4,  'Ibuprofen 400',      'Anti-inflammatory painkiller',     2,  5.60, 250);
insert into medicine values (5,  'Vitamin C 1000',     'Ascorbic acid for immunity',       3,  9.80, 180);
insert into medicine values (6,  'Vitamin D3',         'Supports bone health',             3, 14.20,  90);
insert into medicine values (7,  'Zinc and Selenium',  'Mineral complex supplement',       3, 11.00,   0);
insert into medicine values (8,  'Moisturizing Cream', 'Cream for dry skin',               4, 22.50,  45);
insert into medicine values (9,  'Sunscreen SPF 50',   'High protection sunscreen',        4, 29.90,  30);
insert into medicine values (10, 'Kids Syrup',         'Fever reducer for children',       5,  7.75, 150);
 
-- ---------- 4. PURCHASE ----------
create table purchase
(
  purchaseid        number primary key,
  purchasedate      date         not null,
  medicineid        number       not null,
  supplierid        number       not null,
  purchaseprice     number(10,2) not null,
  quantitypurchased number       not null,
  foreign key (medicineid) references medicine(medicineid),
  foreign key (supplierid) references supplier(supplierid)
);
 
insert into purchase values ( 1, trunc(sysdate) -   3,  3, 1,  1.80, 200);
insert into purchase values ( 2, trunc(sysdate) -   5,  1, 2,  7.20,  50);
insert into purchase values ( 3, trunc(sysdate) -   9,  5, 1,  5.10, 100);
insert into purchase values ( 4, trunc(sysdate) -  14,  4, 3,  2.90, 120);
insert into purchase values ( 5, trunc(sysdate) -  21, 10, 1,  4.00,  80);
insert into purchase values ( 6, trunc(sysdate) -  27,  2, 2, 11.30,  40);
insert into purchase values ( 7, trunc(sysdate) -  35,  6, 4,  8.60,  60);
insert into purchase values ( 8, trunc(sysdate) -  48,  8, 3, 13.00,  30);
insert into purchase values ( 9, trunc(sysdate) -  55,  9, 4, 17.50,  25);
insert into purchase values (10, trunc(sysdate) -  62,  3, 1,  1.75, 300);
insert into purchase values (11, trunc(sysdate) -  75,  7, 2,  6.40,  50);
insert into purchase values (12, trunc(sysdate) -  88,  1, 1,  7.00,  70);
insert into purchase values (13, trunc(sysdate) - 120,  4, 3,  2.85, 100);
insert into purchase values (14, trunc(sysdate) - 200,  5, 4,  5.00, 150);
 
-- ---------- 5. SALE ----------
create table sale
(
  saleid       number primary key,
  saledate     date         not null,
  medicineid   number       not null,
  saleprice    number(10,2) not null,
  quantitysold number       not null,
  foreign key (medicineid) references medicine(medicineid)
);
 
insert into sale values ( 1, trunc(sysdate) -   1,  3,  4.50, 30);
insert into sale values ( 2, trunc(sysdate) -   2,  1, 15.00, 10);
insert into sale values ( 3, trunc(sysdate) -   3,  5, 12.00, 20);
insert into sale values ( 4, trunc(sysdate) -   4,  3,  4.50, 25);
insert into sale values ( 5, trunc(sysdate) -   6, 10,  9.50, 15);
insert into sale values ( 6, trunc(sysdate) -   7,  4,  7.00, 12);
insert into sale values ( 7, trunc(sysdate) -  10,  2, 24.00,  8);
insert into sale values ( 8, trunc(sysdate) -  13,  1, 15.00,  6);
insert into sale values ( 9, trunc(sysdate) -  18,  6, 17.50, 10);
insert into sale values (10, trunc(sysdate) -  23,  3,  4.60, 40);
insert into sale values (11, trunc(sysdate) -  26,  4,  7.20, 18);
insert into sale values (12, trunc(sysdate) -  29,  5, 12.50, 22);
insert into sale values (13, trunc(sysdate) -  40,  8, 27.00,  5);
insert into sale values (14, trunc(sysdate) -  52,  9, 34.00,  3);
insert into sale values (15, trunc(sysdate) -  70,  7, 13.50, 12);
insert into sale values (16, trunc(sysdate) -  95,  8, 26.50,  6);
insert into sale values (17, trunc(sysdate) - 130, 10,  9.00, 20);
insert into sale values (18, trunc(sysdate) - 160,  2, 23.50,  5);
 
commit;
