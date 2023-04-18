--Hangi nakliyeci hangi ürünü hangi müþteriye adet ve toplam olarak ne götürmüþtür.
create view NakliyeciSatislar1
as
select n.SirketAdi,m.MusteriAdi, Count(s.SatisID) as 'Satýlan adet' , Sum(sd.BirimFiyati) as 'Toplam Kazanç' from Nakliyeciler n
left join Satislar s on n.NakliyeciID=s.ShipVia
left join Musteriler m on m.MusteriID=s.MusteriID
left join [Satis Detaylari] sd on S.SatisID=sd.SatisID
group by n.SirketAdi, m.MusteriAdi

