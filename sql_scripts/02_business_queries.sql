--      +----------------+                    +------------------+
--      |   CATEGORY     |                    |    SUPPLIER      |
--      +----------------+                    +------------------+
--      | PK categoryid  |                    | PK supplierid    |
--      |    categoryname|                    |    suppliername  |
--      |    category... |                    |    supplier...   |
--      +----------------+                    +------------------+
--             |1                                      |1
--             |                                       |
--             |                                       |
--             |N                                      |N
--      +---------------------+   1        N   +------------------+
--      |      MEDICINE       |----------------|    PURCHASE      |
--      +---------------------+                +------------------+
--      | PK medicineid       |                | PK purchaseid    |
--      |    medicinename     |                |    purchasedate  |
--      |    medicinedescr... |                | FK medicineid    |
--      | FK categoryid       |                | FK supplierid    |
--      |    price            |                |    purchaseprice |
--      |    quantityinstock  |                |    quantitypurch.|
--      +---------------------+                +------------------+
--             |1
--             |
--             |N
--      +------------------+
--      |      SALE        |
--      +------------------+
--      | PK saleid        |
--      |    saledate      |
--      | FK medicineid    |
--      |    saleprice     |
--      |    quantitysold  |
--      +------------------+




select *from supplier ;
select *from purchase ;
select *from sale;
select *from medicine ;
select *from category ;
--  1.  Anbarda neçə fərqli məhsul (medicine) qeydə alınıb?

select count(distinct medicineid) total_distinct_medicines from medicine;

--  2.  Son bir ayda 'AzFarm LLC' təchizatçısından alınmış bütün
--      məhsulların ümumi alış dəyəri nə qədərdir?

select
    sum(p.purchaseprice*p.quantitypurchased) total_purchase_value
from supplier s join purchase p on s.supplierid = p.supplierid
where s.suppliername = 'AzFarm LLC' and p.purchasedate >= sysdate - 30;

--  3.  Son rübdə (90 gün) hansı təchizatçı ən çox sayda məhsul təqdim edib?

select 
    s.supplierid,
    s.suppliername,
    sum(p.quantitypurchased) total_quantity_supplied
from supplier s join purchase p on s.supplierid = p.supplierid join medicine m on p.medicineid = m.medicineid
where p.purchasedate >= sysdate - 90
group by s.supplierid,s.suppliername
order by sum(p.quantitypurchased) desc
fetch first 1 row only;

--  4.  Ötən həftə (son 7 gün) neçə satış əməliyyatı olub və ümumi satış
--      gəliri nə qədərdir?

select 
    count(saleid) total_sales_count,
    sum(quantitysold * saleprice) total_revenue
from sale 
where saledate >= sysdate - 7;

--  5.  Qiyməti ən yüksək olan məhsul hansıdır?

select 
    medicineid,
    medicinename,
    price
from medicine
where price = (select max(price)from medicine);

--  6.  Hansı məhsullardan alınan miqdar satılan miqdardan çoxdur
--      (yəni hələ də satılmamış qalıq var)?

select 
    m.medicineid,
    m.medicinename,
    p.total_purchased total_purchased,
    s.total_sold total_sold,
    (p.total_purchased - s.total_sold)  stock_remaining
from medicine m
left join (select 
                medicineid, 
                sum(quantitypurchased) total_purchased
           from purchase
           group by medicineid) p on m.medicineid = p.medicineid
left join (select 
                medicineid, 
                sum(quantitysold) as total_sold
           from sale
           group by medicineid) s on m.medicineid = s.medicineid
where p.total_purchased > s.total_sold;

--  7.  Hansı kateqoriyada ən çox məhsul var?

select 
    c.categoryid,
    c.categoryname,
    count(m.medicineid) 
from category c join medicine m on c.categoryid = m.categoryid
group by c.categoryid,c.categoryname
order by count(m.medicineid)desc
fetch first 1 row only;

--  8.  Hər bir məhsulun orta satış qiyməti nə qədərdir?

select 
    m.medicineid,
    m.medicinename,
    round(avg(s.saleprice),2) average_sale_price
from medicine m join sale s on m.medicineid=s.medicineid
group by m.medicineid,m.medicinename;

--  9.  Son bir ayda neçə fərqli təchizatçı məhsul tədarük edib?

select 
    count(distinct supplierid) different_supplier_count
from purchase
where purchasedate >= sysdate - 30;

-- 10.  Son bir ayda heç satılmayan məhsullar hansılardır?

select 
    m.medicineid,
    m.medicinename
from medicine m
left join sale s on m.medicineid = s.medicineid and s.saledate >= sysdate - 30
where s.medicineid is null;

