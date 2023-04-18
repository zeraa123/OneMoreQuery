--Hangi nakliyeci hangi �r�n� hangi m��teriye adet ve toplam olarak ne g�t�rm��t�r.
create view NakliyeciSatislar1
as
select n.SirketAdi,m.MusteriAdi, Count(s.SatisID) as 'Sat�lan adet' , Sum(sd.BirimFiyati) as 'Toplam Kazan�' from Nakliyeciler n
left join Satislar s on n.NakliyeciID=s.ShipVia
left join Musteriler m on m.MusteriID=s.MusteriID
left join [Satis Detaylari] sd on S.SatisID=sd.SatisID
group by n.SirketAdi, m.MusteriAdi

