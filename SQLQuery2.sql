Select UrunAdi, BirimFiyati as KdvHaric,
(BirimFiyati*0.18 + BirimFiyati) as KdvDahil
from Urunler 
Where (BirimFiyati*0.18) <10

SELECT TOP 5 UrunAdi, 
(BirimFiyati*0.18 + BirimFiyati) as KDVDAHil
from Urunler Order By 2 Desc

SELECT TOP 5 UrunAdi, 
(BirimFiyati*0.18 + BirimFiyati) as KDVDAHil
from Urunler Order By 2 Asc

SELECT AVG(Tablomuz.KDVDAHil) FROM (
SELECT TOP 5 UrunAdi, 
(BirimFiyati*0.18 + BirimFiyati) as KDVDAHil
from Urunler Order By 2 Asc) AS Tablomuz

SELECT UPPER(UrunAdi) FROM Urunler

Select count(UrunID) as miktar from Urunler
where BirimFiyati=0;

Select UrunAdi From Urunler 
where BirimFiyati=(
Select MAX(BirimFiyati) From Urunler);

-- mÜşterilerin ülkelere göre sayılarını veren sorgu

Select Ulke, COUNT(MusteriID)
From Musteriler Group by Ulke

--personel adý Nancy veya Janet olan, 
--nakliyecisi speedy express olan satýþlarý

Select* From Satislar WHERE PersonelID IN ( Select PersonelID From Personeller 
where Adi='Janet' or Adi='Nancy') and ShipVia = (Select NakliyeciID From Nakliyeciler 
where SirketAdi='speedy express')


select * from Personeller where Adres IS NULL;

-- Her kategoride kaç ürün vardır?

Select KategoriAdi, COUNT(UrunID) From Urunler INNER JOIN
Kategoriler ON Urunler.KategoriID=Kategoriler.KategoriID
Group by KategoriAdi

-- Çalışanlar ne kadarlık satış yapmıştır?

Select e.Adi, Count(s.SatisID) as SatışSayısı, 
Sum(Sd.BirimFiyati) as ToplamFiyat From Personeller e 
Inner Join Satislar s ON
e.PersonelID=s.PersonelID
Inner Join [Satis Detaylari] Sd
ON s.SatisID=Sd.SatisID
Group By e.Adi

-- Hangi sipariş bana ne kadar kazandırmış?

Select s.SatisID, SUM(sd.BirimFiyati*sd.Miktar*(1-sd.İndirim)) as Kazanç
From Satislar s Inner Join [Satis Detaylari]
sd ON  s.SatisID=sd.SatisID Group By s.SatisID
Order By SatisID Asc

--50den fazla satışı olan çalışanlar 

/* Outer  join
3 çeşit outer join vardır.
Left Outer Join: Left tablo ilk yazılan soldaki tablodur.
Sol tablodaki tüm kayıtlar gelir null olsa dahi ve sağ
tablodan sol tablonun ilişkili kayıtları getirilir. sol tablo+
sağın solla ilişkili olan kısmı.*/

/* INNER JOINde yalnızca kesişim alanları gelir*/

select *from Kategoriler

select *from Kategoriler k left outer join Urunler u 
on k.KategoriID=u.KategoriID

select *from Urunler

select *from Urunler k left outer join Kategoriler u 
on k.KategoriID=u.KategoriID

select *from Kategoriler

select *from Kategoriler k right outer join Urunler u 
on k.KategoriID=u.KategoriID

select *from Urunler

select *from Urunler k right outer join Kategoriler u 
on k.KategoriID=u.KategoriID

/*
Full Outer Join: hem sağdaki hem de soldaki tablodan null
kayıtlar dahil tüm kayıtları getirir.
*/

select *from Kategoriler

select *from Kategoriler k full join Urunler u 
on k.KategoriID=u.KategoriID

select *from Urunler

select *from Urunler k full join Kategoriler u 
on k.KategoriID=u.KategoriID

-- Hiç Satış yapılmayan müşteriler.

select m.MusteriAdi From Satislar s 
Right Join Musteriler m
ON s.MusteriID=m.MusteriID where SatisID is null

-- Hiç Nakliye yapmayan nakliyeciler

select * From Satislar s
Right Join Nakliyeciler n
ON s.ShipVia=n.NakliyeciID 
where s.ShipVia is null

-- Hangi Ürün Hangi Kategoridedir?

Select UrunAdi,KategoriAdi From Urunler Inner Join Kategoriler 
On Kategoriler.KategoriID=Urunler.KategoriID

-- Hangi personel hangi üründen satış yapmamıştır.

Select p.Adi as UrunAdi From  Personeller p
Inner Join Satislar s ON p.PersonelID=s.PersonelID 
Inner Join [Satis Detaylari] sd ON s.SatisID=sd.SatisID
Right Join Urunler u On sd.UrunID=u.UrunID where u.UrunID is null 

/* Cross Join kartezyen çarpım için kullanılır. */


