SELECT *FROM Urunler where UrunAdi not like '%c%' and UrunAdi not like '%a%'

--PersonelIDsi 4 olan ve nakliyeci ucreti 15 ile 45 aras�nda olan
--Personel s�rlayarak son 3 kayd� getiren sat��lar� listeleyiniz.

Select top 3 *From Satislar where PersonelID=4 and NakliyeUcreti between 15 and 45 order by SevkTarihi desc

-- aggregate fonksiyonlar
-- 5 tane fonksiyon t�r� vard�r.
-- select ile from aras�na yaz�l�r.
-- kullan�l�rken yan�na kolon getirilemez(�imdilik)
-- (count, sum, avg, max,min)

Select COUNT(KategoriAdi) from Kategoriler

Select sum (HedefStokDuzeyi) from Urunler 

Select SUM(HedefStokDuzeyi) from Urunler where TedarikciID=7

Select Sum(BirimFiyati*HedefStokDuzeyi) from Urunler

Select Avg(BirimFiyati) FROM Urunler

Select MAX(HedefStokDuzeyi) from Urunler

Select Min(BirimFiyati) from Urunler

Select KategoriID, count(UrunAdi) �r�nAdetleri 
from Urunler group by KategoriID

-- Hangi tedarik�iden ka� adet �r�n al�nm��t�r.

Select TedarikciID, count(UrunAdi) as �r�nAdetleri from Urunler group by TedarikciID

-- Urunler tablosunda hangi kategoriden ka� adet vard�r ve toplam ka� adettir.

Select KategoriID, count(KategoriID),SUM(HedefStokDuzeyi) �r�nAdetleri 
from Urunler group by KategoriID

-- SubQuery

Select KategoriID, COUNT(KategoriID) KategoreiSay�s�, SUM(HedefStokDuzeyi) kategoriStokToplamas�, 
SUM(HedefStokDuzeyi*BirimFiyati) toplamsatis
from Urunler group by KategoriID

-- Hangi Tedarik�iden ka� adet tedarik yap�lm��

Select TedarikciID, COUNT(TedarikciID) TedarikSay�s�, SUM(HedefStokDuzeyi) Tedarik�iStokToplamas�, 
SUM(BirimFiyati*HedefStokDuzeyi) ToplamFiyat
from Urunler group by TedarikciID

-- �lkelere sevkedilen �r�nlerin toplam nakliye �cretleri

Select SevkUlkesi,  SUM(NakliyeUcreti) Toplam, COUNT(NakliyeUcreti) Adet, AVG(NakliyeUcreti) Ortalama
from Satislar group by SevkUlkesi

--Hangi personel hagi m��teriye ka� adet ve ka� lira sat�� yapm��t�r

Select MusteriID, PersonelID, COUNT(SatisID) Satis
from Satislar group by PersonelID, MusteriID order by MusteriID, Satis desc

--Ortalamas� iyi olan personele �d�l

Select *From Urunler Where BirimFiyati>5


Select UrunAdi, (Select SirketAdi From Tedarikciler where TedarikciID=Urunler.TedarikciID), 
(select KategoriAdi from Kategoriler where KategoriID=Urunler.KategoriID),
BirimFiyati, HedefStokDuzeyi from Urunler

-- Sat��lar tablosunu, m��teri ad� �nvan�, personel ad�, soyad� ile ekrana yazd�r.

Select (Select MusteriAdi From Musteriler where MusteriID=Satislar.MusteriID),
 (Select MusteriUnvani From Musteriler where MusteriID=Satislar.MusteriID),
(Select Adi From Personeller where PersonelID=Satislar.PersonelID),
(Select SoyAdi From Personeller where PersonelID=Satislar.PersonelID)
from Satislar

--�r�nler tablosu ile birlikte her bir �r�n�n toplam
-- sat�� adedinin bilgisini g�steren sorguyu ekrana yazar.

Select UrunAdi,(Select SUM(SatisID) as 'Sat�� Say�s�' 
From [Satis Detaylari] WHERE SatisID=Satislar.SatisID )
, (Select SUM(Miktar) AS 'Sat�� Adedi' 
from [Satis Detaylari])
from Urunler

Select *from Satislar

Select (select MusteriAdi From Musteriler Where MusteriID=Satislar.MusteriID) as Musteriler
, (Select Adi From Personeller Where PersonelID=Satislar.PersonelID) as Sat�c�lar
From Satislar

-- SATI�LARDAN MAKS�MUM SATI� F�YATINI ALIN

Select (select MAX(BirimFiyati) from [Satis Detaylari] 
where SatisID=[Satis Detaylari].SatisID) From Satislar

Select UrunAdi ,(select MAX(BirimFiyati) from [Satis Detaylari] 
where UrunID=Urunler.UrunID) as MaksimumFiyat from Urunler Order by 2 desc

Select * From Urunler where TedarikciID=
(Select TedarikciID From Tedarikciler
Where MusteriAdi='Karkki Oy')

--sat��lardaki sat�� id ile sat�� detaylar�ndaki en y�ksek birim fiyat� bulma
--ve en y�ksek �r�n id sini bulma
select (select Urunadi from Urunler where UrunID=(select max(UrunID) 
from [Satis Detaylari] SD where sd.SatisID=s.SatisID)) ,
(select max(sd.BirimFiyati) from [Satis Detaylari] SD where sd.SatisID=s.SatisID), 
* from Satislar S

select (select max(UrunID) from [Satis Detaylari] SD where sd.SatisID=s.SatisID) ,
(select max(sd.BirimFiyati) from [Satis Detaylari] SD where sd.SatisID=s.SatisID),
* from Satislar S

select *from [Satis Detaylari] sd where sd.SatisID =10250
select max(UrunID) from [Satis Detaylari] SD where sd.SatisID=10250

-- ad� robert olan personelin yapt��� sat��lar

select UrunAdi,
(select KategoriID from Kategoriler where KategoriID=u.KategoriID),
(select SirketAdi from Tedarikciler where TedarikciID=u.TedarikciID)
from Urunler u

select* from Kategoriler
select * from Urunler
where KategoriID=
(Select KategoriID from Kategoriler
where KategoriAdi='produce')

select *from Satislar where PersonelID in (select PersonelID from
Personeller where  Adi='Robert' or Adi='Nancy')

--�ay �r�nlerinin sat��lar� chai

Select *from Satislar where SatisID in 
(select COUNT(UrunID) from [Satis Detaylari] where SevkAdi='Chai')

Select *From [Satis Detaylari] sd
Where UrunID=(Select UrunID From Urunler u Where UrunAdi='Chai')

--personel ad� Nancy veya Janet olan, 
--nakliyecisi speedy express olan sat��lar�

select *from Satislar where PersonelID in (select PersonelID from
Personeller where  Adi='Janet' or Adi='Nancy' ) and
ShipVia=(select NakliyeciID from Nakliyeciler where SirketAdi=
'speedy express')

--1997 y�l�nda yap�lan sat��larda ne kadar ciro edildi�ini

select (Select SatisID, Sum(Miktar*BirimFiyati*(1-�ndirim)) 
from [Satis Detaylari] where SatisID=Satislar.SatisID )
from Satislar
where SatisTarihi between '1997.01.01' and '1997.12.31'

select sum(sd.BirimFiyati*sd.Miktar*(1-sd.�ndirim)) 
from [Satis Detaylari] sd 
where sd.SatisID in 
(select s.SatisID from Satislar s 
where s.SatisTarihi between '1997.01.01' and '1997.12.31')

