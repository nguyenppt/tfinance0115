USE [bisolutions_vvcb]


BEGIN
update BEXPORT_DOCUMETARYCOLLECTION 
set status = 'CAN'

where Cancel_Status='AUT'
END
GO