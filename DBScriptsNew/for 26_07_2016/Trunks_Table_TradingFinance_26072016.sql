USE [bisolutions_vvcb]


BEGIN
update BCurrency set Vietnamese ='do la Uc' where Code = 'AUD'
update BCurrency set Vietnamese ='do la Canada' where Code = 'CAD'
update BCurrency set Vietnamese ='do la Nhan Dan Te' where Code = 'CNY'
update BCurrency set Vietnamese ='Euro' where Code = 'EUR'
update BCurrency set Vietnamese ='dong Bang Anh' where Code = 'GBP'
update BCurrency set Vietnamese ='Vang' where Code = 'GOLD'
update BCurrency set Vietnamese ='do la Hong Kong' where Code = 'HKD'
update BCurrency set Vietnamese ='dong Yen Nhat' where Code = 'JPY'
update BCurrency set Vietnamese ='do la New Zealand' where Code = 'NZD'
update BCurrency set Vietnamese ='do la Singapore' where Code = 'SGD'
update BCurrency set Vietnamese ='do la My' where Code = 'USD'
update BCurrency set Vietnamese ='Viet Nam dong' where Code = 'VND'
END
GO