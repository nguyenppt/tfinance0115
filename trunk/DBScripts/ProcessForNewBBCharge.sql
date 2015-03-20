--insert EC.OVERSEASMINUS EC.OVERSEASPLUS

INSERT INTO [BCHARGECODE] 
([Code], [Name_EN], [Name_VN], [PLAccount], [PaymentEC])
VALUES
('EC.OVERSEASMINUS', N'OVERSEAS BANK CHARGES COLLECT FROM DOCS VALUE', N'Phí Ngân hàng nước ngoài trừ trước khi báo có', '', 'x'),
('EC.OVERSEASPLUS', N'CHARGES PAYED BY OVERSEAS BANK', N'Phí Ngân hàng nước ngoài báo có thêm', '', 'x');
