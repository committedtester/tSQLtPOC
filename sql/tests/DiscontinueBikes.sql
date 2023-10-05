USE [AdventureWorksLT2022]
GO

EXEC tSQLt.NewTestClass 'testDiscontinueBike';
GO

CREATE PROCEDURE testDiscontinueBike.[test Discontinue Bike - Confirm Bike Records only are Discontinued]
AS
BEGIN
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
	IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;


------Fake Table
    EXEC tSQLt.FakeTable 'SalesLT', 'Product';
	INSERT [SalesLT].[Product] ([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]) VALUES (749, N'Road-150 Red, 62', N'BK-R93R-62', N'Red', 2171.2942, 3578.2700, N'62', CAST(6803.85 AS Decimal(8, 2)), 6, 25, CAST(N'2005-07-01T00:00:00.000' AS DateTime), CAST(N'2006-06-30T00:00:00.000' AS DateTime), NULL, 0x47494638396150003100F70000920407C6BCC339343A585459D0162DF9F9FDF9F9F9DCDBDBDBE4E8A92E37F978885B2129D3CACEC4C1C5F9EBEC876A6F484349A8454DF4F4FAEDEDF5F1F1F1E3E3E4EEEDF8C66A76665D64837D83F0EEF4E0DEE4BDC5CEE7000F70859FE9F3F6A03946D4D2D4F5F5FCCCC9D5CD354F2A242AB2ADB2FEF3F6EEEDED433D43C12432B5B1B2B8B6C1D3D2DBCDCACBFEFEFEBDBBBDB1AAADE3E1F4928E91929193A5A2A5FDDCDECCCFD9E8CACAF7F7FCF3FBFEC69AAE6B656CFD8892E9E7E89D9A9DD0CED2BAB3B5DCDAEDC80005CA7683DFDDDEF1F1F6C9C5CB6C6C77DDDCE07D757AFB6779F82B46B70016A60115F0EFEFA51E24FDA2A9B062678B898CF9FEFED48A8B716D72FBFCFE7F7C809A9499A9A4ADFCFCFCE4E3EAF3F2FAACAAACF0F0F8A89B9CACB2B5DAA9A9ABA8B188848AFA56698A8B92C14C57EEEEF1E9E9EAE40024E2E0DDB98E92C6C5C5D8536FFDC8C9E9E8EE5B5963544E53747274CB83863D393FA9565E894C56F2F1FDC20113F7F6F7E8E4E1F5F4F5E8E6F3FB98A2EDEBF2FDB6B9C5C3CCFCFBFCCBA1A6828086AB8E98EBEAF26D696BBB0005DAD7DE726A6FF3F2F3D10315BC808CB5B3B98A1628BDB5BCDEB5B46E737BE74561EDEAED88838574747EE0BABADED9D6F6F4F5F4F3F98F9598EBD4D3ED1436EAE8F6E4D2D1C2BEC1F8F1F0F5F9F7635F64FDA9B3A6A6A82C32409E9EA0D60009322E32FDFFFE908D8EF8F7F7F7F6F4F6F4F8F0EFFB7C797DFBFAFAF2F2F7ECEAF5EBEAEBD5D2E1D7D5D76763677E808BFFFEFDFCFCFAE1E9E9D8D9D9F2F0F9242024A40003A39DA2EDECEB97949768626BF2F1FAFDFDFD4F4B50F4F3FD2E292DF61937DAD7E6BD1422F5F5F5EF082B211C1FD6D0C89FA0AAB7B7B7F3F6F8797378EFDCDCDA9DA2C58B8ECE9596C33B3DE24D78E25A66DEC0C1FED3DF68696A60595F4D5457334962F6F5F5F0F2FAE1003750454DA07D88BFC0C4EEAEB49BA9C1869DC59F1115ACA8A7F1507BADA2A8D4E1E7FA3E57EBECEFF9273FE3D7DAF9FBFBDD1E48DFDEEDF4F3F27F3847CD0C1E97909696999DC0D3E0FDFDFF999999F1F1F8FFFFFF21F90400000000002C00000000500031000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710234A5CC8ECC9C48B18257AC1C227A3C02D05AF88BBA1AF9847894506F058E4B101162C66689C4297CE03B85327236EA15102C39C53262F1A48D2C69C2401A692E2CC0931960B08290ED5B097D3450A452656309D38236A3E13AB56B1C4086A45C7AD13EDF1320004960008B430B20AB206EDC91502C264AC506AACDD894638A85876EE04C66835FE627457A883E36465A2D888586C140CC513E7ED3BD301448226433A347BD7E34DAC86BB7804C32C71020B0288B4B5FA642D821344A8D4305902C841420752DA89621DD15D23544ED49419B867901D28884243F633B92020548D8843BCB28F042200C997E4FF2218EAD285CFA1472B7863F89F024638B43FFC6082D12F285000A8597250100E3A50FC9207236AC4B304294CA8309C7C0DB973C17738500345720AA8821035D820924713A0A9A1C6050C1A4441112EB401C401B41820D82F6208C4893AC9F590503155E0A3861B1710C048240751E0420DAB903185302BD4E5D11330CC30C728710C10471CA398B1C310551084038C6AF861902A2F08F40936A82C31C932A114644B3EDEA420401D6CA6924A1DB7AC60C044B194320A39750C300C12965832CC001EB8F1C826710D746572512844451543A841C20703D13203396E0E600519421232CD00C8F832401B0205C5D00656B0E9CD145EC0D040200D38728A16042CFF5007060D58096333A42C540D6E2484F04F08B7A4828C1C3444534412451CB00626415402812FC8F4F3CF16A22614821C02C891CF1115D0128B1E1674A12211EA4832400AE40441D036B702A290024D48C1083E8D7CF32616A02C62510EFFE450404507C4C00332CE90F1CF3C5D26548431026010C406391C63801E1A5820012B1C906007022BDC822E28045D025E276F20944B3C2AA8C2890AA83C02C1263EF023422BAC88F0CF04AC3C310F0A1480324D2ACE480B1242CCDC22C03001F8E0CA3F5D18D18A2CAF48204A00CB04F08F2C6DCC91821C071014C9C8251B64430744FC23CD000B0C41C00E9012E3B426FCE0FC040ACC5C21411B56A452820BFF24FF6C503FA90C00C906FFC4B24831162C22011E12E850450254102341310D0C238022821024C6C89328400A3786A9E2072ADBFC334309022881CD101724A1CA2B8BF8538006CCF8F044015FFC73450CDE9430801E085500411D596C7085052F1890490E8618718C1E1F60C3860E12300D87090C5FA63978E3342120019D93A04228BBD4818C37BBCC4384DA83B8B3812CFF14104C052288A34A0E16F031C3B37A1DF4432A3C38021F8A81BFE4E961167D10810EB60185165CE11FB3F8C33F92400801F0606803D95C13E8D1082924401DBF68421EE84182472CA010C7A0822A18800D4610E106E638822D8A00872EA8A2001310042B1A708B1278A35A0231C000FF04908F0ABC201CB1C8C12BFE61005AC820071FB8400420D5073408C2021A808131529008835403007960874016C1060048210200E0103E48E0063F70A30F74C04719CA310A3998C366399845CE98C10C3298AF6B05498200C80189456422138BB0471788F10F14B4A016A050C1031A60013448C00239D8822DAC2080761CE41A69CC86062A00860754C01D6A7A4023ECF0C126804F0543C0073904E005DDCD82125CF8C317FC31067238231A0681013286E18262144310DFA2C01F66B1864470C08396C8401226F08770848315695885003280106B00E01E96C0822224618218D4C118A7D8450578D1807694C30E208002081EF18052B4E1065C80832CF470FF1A170CC0173F3048294A300D2074E10B13B080052600875A0081059280C21D5280817AF4A20B22F0171A6A50074524A4104FC202186A4008329420053068051FF5300F2A88220C33B88737EE608E680001085FF84217BAE00F208CA2045830C82990010B5B10841F48DD402D6001817B280203BE1244010AE02F7894A20EC3188F410441832C2801031850823046810C0800C120C5604118B270877B68C157693092400EF0532B0814194A1841178E210209488018AF108210A680D50640421057482C62AF4081ABF2C06F04414106F2010B0C9C2A1F032881318E600462EC540413A8872358508A5528620C8198451712D1D72E48C0A7BE98433053A10806FFFCE39839F8421F64D007658C400B8148843284E0093C88E0B89AE0C20F52879070D0601596C0451C5650031EA40202A0DAC2C428B1817AB4C0112680C129CC0107216C40AF2228C00B1A300067D0C020BC10803702308183F661160AFD471F4670DE0AFCC30286D0003132CA8F226081880931C134A0810B4554025F6C7204CF9EC005437CE11894A8040D6A500913D8E30F40D8001C2630812F9C821CBE006641F4208714B4831205B040012490BB1C98F71F32E042972CE08A4CB8A200C468C028EA00328418E007B8B0C234CCE0ABCCD2E07613C8C122FF01845B80820240C88223D600871C188002BAA00416EA2000FF1A6415A9C8C00844508C5DFEE3FF92F530C47FB990892DBC40C67A30401A6AB0350A288417481086096C618F70E4C37723D0C43F5E913B56AC6015A7F982215EC12F8C6E410FA018985D0F7280AD99C007C750B4387A81064F18E11FFE30442FC2510C7E58E00A06C09B0066B0905210A24B0678022D80E00D39FCA0027D80C3169E108C5128822A08D58006144D8C0250C20C104006A8105289D4054003FFF5072BB8A089DC7D81029E10041F5E70053CD8220B2930860F14620F24D4B2206440863160B0816060A2089838841578F10F0D88000E5754B406C630B0430091206968713E18F00709E82218FEC82DD35861043C148325B6D0821CEAF06E843C611D5658012B0A420B7294E01021FFA00533B6408B60B0C2CF1328803F28F0822EA0011415AC431116D2067465E10828408301BE2073A6C5A21522E047385CE0056F6CF3E00461860B36608B831F4100C8B002D09F90EB17B0640257F8C2C47CC08229A400192A5E48345200013204A008ADC89DCDF0F08F701820110DC8C210E7C00C8F444300BE3341089E60918EF8E3660E6080233250875494E221E630065681E10279F8001E0640C31342D0002DCC617895E8FB491AF02C014C2306CFD8C31AF6D0024C30200833C86C1DD2EE9035C0A20E291845067E100348AC001864E00104B2E508B454E067CE488531AC50094C296114102801320EB1F389B481A96B8280F6D594A71F14CA2E6D89B6412F7C5182F1FBA20E73E05BDF22F2822E6D81175EC840376ED18D39AC0214AB593F5A2CF40F5A80A21F531080ABE005BCA007ACC00AB1606721B2800CD880091110003B, N'superlight_red_small.gif', N'bc621e1f-2553-4fdc-b22e-5e44a9003569', CAST(N'2008-03-11T10:01:36.827' AS DateTime))
	INSERT [SalesLT].[Product] ([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]) VALUES (750, N'Road-150 Red, 44', N'BK-R93R-44', N'Red', 2171.2942, 3578.2700, N'44', CAST(6245.93 AS Decimal(8, 2)), 6, 25, CAST(N'2005-07-01T00:00:00.000' AS DateTime), CAST(N'2006-06-30T00:00:00.000' AS DateTime), NULL, 0x47494638396150003100F70000920407C6BCC339343A585459D0162DF9F9FDF9F9F9DCDBDBDBE4E8A92E37F978885B2129D3CACEC4C1C5F9EBEC876A6F484349A8454DF4F4FAEDEDF5F1F1F1E3E3E4EEEDF8C66A76665D64837D83F0EEF4E0DEE4BDC5CEE7000F70859FE9F3F6A03946D4D2D4F5F5FCCCC9D5CD354F2A242AB2ADB2FEF3F6EEEDED433D43C12432B5B1B2B8B6C1D3D2DBCDCACBFEFEFEBDBBBDB1AAADE3E1F4928E91929193A5A2A5FDDCDECCCFD9E8CACAF7F7FCF3FBFEC69AAE6B656CFD8892E9E7E89D9A9DD0CED2BAB3B5DCDAEDC80005CA7683DFDDDEF1F1F6C9C5CB6C6C77DDDCE07D757AFB6779F82B46B70016A60115F0EFEFA51E24FDA2A9B062678B898CF9FEFED48A8B716D72FBFCFE7F7C809A9499A9A4ADFCFCFCE4E3EAF3F2FAACAAACF0F0F8A89B9CACB2B5DAA9A9ABA8B188848AFA56698A8B92C14C57EEEEF1E9E9EAE40024E2E0DDB98E92C6C5C5D8536FFDC8C9E9E8EE5B5963544E53747274CB83863D393FA9565E894C56F2F1FDC20113F7F6F7E8E4E1F5F4F5E8E6F3FB98A2EDEBF2FDB6B9C5C3CCFCFBFCCBA1A6828086AB8E98EBEAF26D696BBB0005DAD7DE726A6FF3F2F3D10315BC808CB5B3B98A1628BDB5BCDEB5B46E737BE74561EDEAED88838574747EE0BABADED9D6F6F4F5F4F3F98F9598EBD4D3ED1436EAE8F6E4D2D1C2BEC1F8F1F0F5F9F7635F64FDA9B3A6A6A82C32409E9EA0D60009322E32FDFFFE908D8EF8F7F7F7F6F4F6F4F8F0EFFB7C797DFBFAFAF2F2F7ECEAF5EBEAEBD5D2E1D7D5D76763677E808BFFFEFDFCFCFAE1E9E9D8D9D9F2F0F9242024A40003A39DA2EDECEB97949768626BF2F1FAFDFDFD4F4B50F4F3FD2E292DF61937DAD7E6BD1422F5F5F5EF082B211C1FD6D0C89FA0AAB7B7B7F3F6F8797378EFDCDCDA9DA2C58B8ECE9596C33B3DE24D78E25A66DEC0C1FED3DF68696A60595F4D5457334962F6F5F5F0F2FAE1003750454DA07D88BFC0C4EEAEB49BA9C1869DC59F1115ACA8A7F1507BADA2A8D4E1E7FA3E57EBECEFF9273FE3D7DAF9FBFBDD1E48DFDEEDF4F3F27F3847CD0C1E97909696999DC0D3E0FDFDFF999999F1F1F8FFFFFF21F90400000000002C00000000500031000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710234A5CC8ECC9C48B18257AC1C227A3C02D05AF88BBA1AF9847894506F058E4B101162C66689C4297CE03B85327236EA15102C39C53262F1A48D2C69C2401A692E2CC0931960B08290ED5B097D3450A452656309D38236A3E13AB56B1C4086A45C7AD13EDF1320004960008B430B20AB206EDC91502C264AC506AACDD894638A85876EE04C66835FE627457A883E36465A2D888586C140CC513E7ED3BD301448226433A347BD7E34DAC86BB7804C32C71020B0288B4B5FA642D821344A8D4305902C841420752DA89621DD15D23544ED49419B867901D28884243F633B92020548D8843BCB28F042200C997E4FF2218EAD285CFA1472B7863F89F024638B43FFC6082D12F285000A8597250100E3A50FC9207236AC4B304294CA8309C7C0DB973C17738500345720AA8821035D820924713A0A9A1C6050C1A4441112EB401C401B41820D82F6208C4893AC9F590503155E0A3861B1710C048240751E0420DAB903185302BD4E5D11330CC30C728710C10471CA398B1C310551084038C6AF861902A2F08F40936A82C31C932A114644B3EDEA420401D6CA6924A1DB7AC60C044B194320A39750C300C12965832CC001EB8F1C826710D746572512844451543A841C20703D13203396E0E600519421232CD00C8F832401B0205C5D00656B0E9CD145EC0D040200D38728A16042CFF5007060D58096333A42C540D6E2484F04F08B7A4828C1C3444534412451CB00626415402812FC8F4F3CF16A22614821C02C891CF1115D0128B1E1674A12211EA4832400AE40441D036B702A290024D48C1083E8D7CF32616A02C62510EFFE450404507C4C00332CE90F1CF3C5D26548431026010C406391C63801E1A5820012B1C906007022BDC822E28045D025E276F20944B3C2AA8C2890AA83C02C1263EF023422BAC88F0CF04AC3C310F0A1480324D2ACE480B1242CCDC22C03001F8E0CA3F5D18D18A2CAF48204A00CB04F08F2C6DCC91821C071014C9C8251B64430744FC23CD000B0C41C00E9012E3B426FCE0FC040ACC5C21411B56A452820BFF24FF6C503FA90C00C906FFC4B24831162C22011E12E850450254102341310D0C238022821024C6C89328400A3786A9E2072ADBFC334309022881CD101724A1CA2B8BF8538006CCF8F044015FFC73450CDE9430801E085500411D596C7085052F1890490E8618718C1E1F60C3860E12300D87090C5FA63978E3342120019D93A04228BBD4818C37BBCC4384DA83B8B3812CFF14104C052288A34A0E16F031C3B37A1DF4432A3C38021F8A81BFE4E961167D10810EB60185165CE11FB3F8C33F92400801F0606803D95C13E8D1082924401DBF68421EE84182472CA010C7A0822A18800D4610E106E638822D8A00872EA8A2001310042B1A708B1278A35A0231C000FF04908F0ABC201CB1C8C12BFE61005AC820071FB8400420D5073408C2021A808131529008835403007960874016C1060048210200E0103E48E0063F70A30F74C04719CA310A3998C366399845CE98C10C3298AF6B05498200C80189456422138BB0471788F10F14B4A016A050C1031A60013448C00239D8822DAC2080761CE41A69CC86062A00860754C01D6A7A4023ECF0C126804F0543C0073904E005DDCD82125CF8C317FC31067238231A0681013286E18262144310DFA2C01F66B1864470C08396C8401226F08770848315695885003280106B00E01E96C0822224618218D4C118A7D8450578D1807694C30E208002081EF18052B4E1065C80832CF470FF1A170CC0173F3048294A300D2074E10B13B080052600875A0081059280C21D5280817AF4A20B22F0171A6A50074524A4104FC202186A4008329420053068051FF5300F2A88220C33B88737EE608E680001085FF84217BAE00F208CA2045830C82990010B5B10841F48DD402D6001817B280203BE1244010AE02F7894A20EC3188F410441832C2801031850823046810C0800C120C5604118B270877B68C157693092400EF0532B0814194A1841178E210209488018AF108210A680D50640421057482C62AF4081ABF2C06F04414106F2010B0C9C2A1F032881318E600462EC540413A8872358508A5528620C8198451712D1D72E48C0A7BE98433053A10806FFFCE39839F8421F64D007658C400B8148843284E0093C88E0B89AE0C20F52879070D0601596C0451C5650031EA40202A0DAC2C428B1817AB4C0112680C129CC0107216C40AF2228C00B1A300067D0C020BC10803702308183F661160AFD471F4670DE0AFCC30286D0003132CA8F226081880931C134A0810B4554025F6C7204CF9EC005437CE11894A8040D6A500913D8E30F40D8001C2630812F9C821CBE006641F4208714B4831205B040012490BB1C98F71F32E042972CE08A4CB8A200C468C028EA00328418E007B8B0C234CCE0ABCCD2E07613C8C122FF01845B80820240C88223D600871C188002BAA00416EA2000FF1A6415A9C8C00844508C5DFEE3FF92F530C47FB990892DBC40C67A30401A6AB0350A288417481086096C618F70E4C37723D0C43F5E913B56AC6015A7F982215EC12F8C6E410FA018985D0F7280AD99C007C750B4387A81064F18E11FFE30442FC2510C7E58E00A06C09B0066B0905210A24B0678022D80E00D39FCA0027D80C3169E108C5128822A08D58006144D8C0250C20C104006A8105289D4054003FFF5072BB8A089DC7D81029E10041F5E70053CD8220B2930860F14620F24D4B2206440863160B0816060A2089838841578F10F0D88000E5754B406C630B0430091206968713E18F00709E82218FEC82DD35861043C148325B6D0821CEAF06E843C611D5658012B0A420B7294E01021FFA00533B6408B60B0C2CF1328803F28F0822EA0011415AC431116D2067465E10828408301BE2073A6C5A21522E047385CE0056F6CF3E00461860B36608B831F4100C8B002D09F90EB17B0640257F8C2C47CC08229A400192A5E48345200013204A008ADC89DCDF0F08F701820110DC8C210E7C00C8F444300BE3341089E60918EF8E3660E6080233250875494E221E630065681E10279F8001E0640C31342D0002DCC617895E8FB491AF02C014C2306CFD8C31AF6D0024C30200833C86C1DD2EE9035C0A20E291845067E100348AC001864E00104B2E508B454E067CE488531AC50094C296114102801320EB1F389B481A96B8280F6D594A71F14CA2E6D89B6412F7C5182F1FBA20E73E05BDF22F2822E6D81175EC840376ED18D39AC0214AB593F5A2CF40F5A80A21F531080ABE005BCA007ACC00AB1606721B2800CD880091110003B, N'superlight_red_small.gif', N'c19e1136-5da4-4b40-8758-54a85d7ea494', CAST(N'2008-03-11T10:01:36.827' AS DateTime))
	INSERT [SalesLT].[Product] ([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]) VALUES (706, N'Should not Update',N'BK-R93R-77', N'Red', 1059.3100, 1431.5000, N'58', CAST(1016.04 AS Decimal(8, 2)), 18, 6, CAST(N'2002-06-01T00:00:00.000' AS DateTime), NULL, NULL, 0x47494638396150003100F70000000000800000008000808000000080800080008080808080C0C0C0FF000000FF00FFFF000000FFFF00FF00FFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000330000660000990000CC0000FF0033000033330033660033990033CC0033FF0066000066330066660066990066CC0066FF0099000099330099660099990099CC0099FF00CC0000CC3300CC6600CC9900CCCC00CCFF00FF0000FF3300FF6600FF9900FFCC00FFFF3300003300333300663300993300CC3300FF3333003333333333663333993333CC3333FF3366003366333366663366993366CC3366FF3399003399333399663399993399CC3399FF33CC0033CC3333CC6633CC9933CCCC33CCFF33FF0033FF3333FF6633FF9933FFCC33FFFF6600006600336600666600996600CC6600FF6633006633336633666633996633CC6633FF6666006666336666666666996666CC6666FF6699006699336699666699996699CC6699FF66CC0066CC3366CC6666CC9966CCCC66CCFF66FF0066FF3366FF6666FF9966FFCC66FFFF9900009900339900669900999900CC9900FF9933009933339933669933999933CC9933FF9966009966339966669966999966CC9966FF9999009999339999669999999999CC9999FF99CC0099CC3399CC6699CC9999CCCC99CCFF99FF0099FF3399FF6699FF9999FFCC99FFFFCC0000CC0033CC0066CC0099CC00CCCC00FFCC3300CC3333CC3366CC3399CC33CCCC33FFCC6600CC6633CC6666CC6699CC66CCCC66FFCC9900CC9933CC9966CC9999CC99CCCC99FFCCCC00CCCC33CCCC66CCCC99CCCCCCCCCCFFCCFF00CCFF33CCFF66CCFF99CCFFCCCCFFFFFF0000FF0033FF0066FF0099FF00CCFF00FFFF3300FF3333FF3366FF3399FF33CCFF33FFFF6600FF6633FF6666FF6699FF66CCFF66FFFF9900FF9933FF9966FF9999FF99CCFF99FFFFCC00FFCC33FFCC66FFCC99FFCCCCFFCCFFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF21F90401000010002C00000000500031000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710234A9C48B1A2C58B18336ADCC8B1A3C78F20438A1C49B2A4C9932853AA5C9911058A812E17C664F9D0E5CB7F3313E6A4C9D0A6C099366FC27C19D367CEA04371DE44CA1169D1A542952A25FA1467D2A7547F46C558542AD0A855A58A9D9AD52BD4A654C3EE547BD6AC58AC3E377E2DBB96EED9AF6FCB7A9C9B97205BAD7DB1F6952B74EED6BF79E3B2DDC95362E1AD8D2F328D4CB9B2E5CB9831C77518D62063C6223743040DD82F6490558FA6BD0B152F5EB2A8B3AA7EEC96B651D96D3BFE9D8D7BE86EBB1F7F034ECD3AF06AD292831237EEB6F9F290AAB5B65DEE9A7A6EC249A7FA7EAEDC79EBD399C38B121F4FBEBCF9F3E8D3AB5FCFBEBDFBF7EF0302003B, N'no_image_available_small.gif', N'9540ff17-2712-4c90-a3d1-8ce5568b2462', CAST(N'2008-03-11T10:01:36.827' AS DateTime))

	EXEC tSQLt.FakeTable 'SalesLT', 'ProductModel';
	INSERT [SalesLT].[ProductModel] ([ProductModelID], [Name], [CatalogDescription], [rowguid], [ModifiedDate]) VALUES (24, N'Racing Socks', NULL, N'bd8ba6f8-7e16-4fa3-b3b3-2036dd4a2ae0', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductModel] ([ProductModelID], [Name], [CatalogDescription], [rowguid], [ModifiedDate]) VALUES (25, N'Road-150', N'', N'94ffb702-0cbc-4e3f-b840-c51f0d11c8f6', CAST(N'2005-06-01T00:00:00.000' AS DateTime))

	EXEC tSQLt.FakeTable 'SalesLT', 'ProductModelProductDescription';
	INSERT [SalesLT].[ProductModelProductDescription] ([ProductModelID], [ProductDescriptionID], [Culture], [rowguid], [ModifiedDate]) VALUES (25, 457, N'en    ', N'beaf13cb-806c-450d-aea8-0eb70008e84d', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductModelProductDescription] ([ProductModelID], [ProductDescriptionID], [Culture], [rowguid], [ModifiedDate]) VALUES (25, 1377, N'ar    ', N'a9c783c7-934a-4d4c-a0a3-05b64c560f81', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductModelProductDescription] ([ProductModelID], [ProductDescriptionID], [Culture], [rowguid], [ModifiedDate]) VALUES (25, 1501, N'fr    ', N'7fb17aa5-b3a0-43fc-9926-b59ec04c6b43', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductModelProductDescription] ([ProductModelID], [ProductDescriptionID], [Culture], [rowguid], [ModifiedDate]) VALUES (25, 1623, N'th    ', N'9609b25a-6446-4577-9894-9d7c1fac3c7e', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductModelProductDescription] ([ProductModelID], [ProductDescriptionID], [Culture], [rowguid], [ModifiedDate]) VALUES (25, 1745, N'he    ', N'1f7e9a2a-3ddf-4bda-bf95-bb64e1604849', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductModelProductDescription] ([ProductModelID], [ProductDescriptionID], [Culture], [rowguid], [ModifiedDate]) VALUES (25, 1872, N'zh-cht', N'3a957c6e-894d-49ed-bbb5-cdebd65ed338', CAST(N'2007-06-01T00:00:00.000' AS DateTime))

	EXEC tSQLt.FakeTable 'SalesLT', 'ProductDescription';
	INSERT [SalesLT].[ProductDescription] ([ProductDescriptionID], [Description], [rowguid], [ModifiedDate]) VALUES (409, N'Alluminum-alloy frame provides a light, stiff ride, whether you are racing in the velodrome or on a demanding club ride on country roads.', N'3dc76714-7572-4547-9d79-abb708950b2c', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductDescription] ([ProductDescriptionID], [Description], [rowguid], [ModifiedDate]) VALUES (457, N'This bike is ridden by race winners. Developed with the Adventure Works Cycles professional race team, it has a extremely light heat-treated aluminum frame, and steering that allows precision control.', N'3ddb8dea-fc37-4e44-8c1d-0bf7c6a723e3', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductDescription] ([ProductDescriptionID], [Description], [rowguid], [ModifiedDate]) VALUES (513, N'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', N'741eae59-5e59-4dbc-9086-2633392c2582', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
	INSERT [SalesLT].[ProductDescription] ([ProductDescriptionID], [Description], [rowguid], [ModifiedDate]) VALUES (554, N'The plush custom saddle keeps you riding all day,  and there''s plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.', N'ddc955b2-843e-49ce-8f7b-54870f6135eb', CAST(N'2007-06-01T00:00:00.000' AS DateTime))


------Execution
EXECUTE [dbo].[DiscontinueBikes]

------Assertion
CREATE TABLE expected (
	[ProductID] [int]  NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[Color] [nvarchar](15) NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) NULL,
	[Weight] [decimal](8, 2) NULL,
	[ProductCategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[ThumbNailPhoto] [varbinary](max) NULL,
	[ThumbnailPhotoFileName] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier]  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL)

DECLARE @currDate DATETIME;
SET @currDate = convert(datetime,0);
        
INSERT expected ([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]) VALUES (749, N'Road-150 Red, 62', N'BK-R93R-62', N'Red', 2171.2942, 3578.2700, N'62', CAST(6803.85 AS Decimal(8, 2)), 6, 25, CAST(N'2005-07-01T00:00:00.000' AS DateTime), CAST(N'2006-06-30T00:00:00.000' AS DateTime), @currDate, 0x47494638396150003100F70000920407C6BCC339343A585459D0162DF9F9FDF9F9F9DCDBDBDBE4E8A92E37F978885B2129D3CACEC4C1C5F9EBEC876A6F484349A8454DF4F4FAEDEDF5F1F1F1E3E3E4EEEDF8C66A76665D64837D83F0EEF4E0DEE4BDC5CEE7000F70859FE9F3F6A03946D4D2D4F5F5FCCCC9D5CD354F2A242AB2ADB2FEF3F6EEEDED433D43C12432B5B1B2B8B6C1D3D2DBCDCACBFEFEFEBDBBBDB1AAADE3E1F4928E91929193A5A2A5FDDCDECCCFD9E8CACAF7F7FCF3FBFEC69AAE6B656CFD8892E9E7E89D9A9DD0CED2BAB3B5DCDAEDC80005CA7683DFDDDEF1F1F6C9C5CB6C6C77DDDCE07D757AFB6779F82B46B70016A60115F0EFEFA51E24FDA2A9B062678B898CF9FEFED48A8B716D72FBFCFE7F7C809A9499A9A4ADFCFCFCE4E3EAF3F2FAACAAACF0F0F8A89B9CACB2B5DAA9A9ABA8B188848AFA56698A8B92C14C57EEEEF1E9E9EAE40024E2E0DDB98E92C6C5C5D8536FFDC8C9E9E8EE5B5963544E53747274CB83863D393FA9565E894C56F2F1FDC20113F7F6F7E8E4E1F5F4F5E8E6F3FB98A2EDEBF2FDB6B9C5C3CCFCFBFCCBA1A6828086AB8E98EBEAF26D696BBB0005DAD7DE726A6FF3F2F3D10315BC808CB5B3B98A1628BDB5BCDEB5B46E737BE74561EDEAED88838574747EE0BABADED9D6F6F4F5F4F3F98F9598EBD4D3ED1436EAE8F6E4D2D1C2BEC1F8F1F0F5F9F7635F64FDA9B3A6A6A82C32409E9EA0D60009322E32FDFFFE908D8EF8F7F7F7F6F4F6F4F8F0EFFB7C797DFBFAFAF2F2F7ECEAF5EBEAEBD5D2E1D7D5D76763677E808BFFFEFDFCFCFAE1E9E9D8D9D9F2F0F9242024A40003A39DA2EDECEB97949768626BF2F1FAFDFDFD4F4B50F4F3FD2E292DF61937DAD7E6BD1422F5F5F5EF082B211C1FD6D0C89FA0AAB7B7B7F3F6F8797378EFDCDCDA9DA2C58B8ECE9596C33B3DE24D78E25A66DEC0C1FED3DF68696A60595F4D5457334962F6F5F5F0F2FAE1003750454DA07D88BFC0C4EEAEB49BA9C1869DC59F1115ACA8A7F1507BADA2A8D4E1E7FA3E57EBECEFF9273FE3D7DAF9FBFBDD1E48DFDEEDF4F3F27F3847CD0C1E97909696999DC0D3E0FDFDFF999999F1F1F8FFFFFF21F90400000000002C00000000500031000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710234A5CC8ECC9C48B18257AC1C227A3C02D05AF88BBA1AF9847894506F058E4B101162C66689C4297CE03B85327236EA15102C39C53262F1A48D2C69C2401A692E2CC0931960B08290ED5B097D3450A452656309D38236A3E13AB56B1C4086A45C7AD13EDF1320004960008B430B20AB206EDC91502C264AC506AACDD894638A85876EE04C66835FE627457A883E36465A2D888586C140CC513E7ED3BD301448226433A347BD7E34DAC86BB7804C32C71020B0288B4B5FA642D821344A8D4305902C841420752DA89621DD15D23544ED49419B867901D28884243F633B92020548D8843BCB28F042200C997E4FF2218EAD285CFA1472B7863F89F024638B43FFC6082D12F285000A8597250100E3A50FC9207236AC4B304294CA8309C7C0DB973C17738500345720AA8821035D820924713A0A9A1C6050C1A4441112EB401C401B41820D82F6208C4893AC9F590503155E0A3861B1710C048240751E0420DAB903185302BD4E5D11330CC30C728710C10471CA398B1C310551084038C6AF861902A2F08F40936A82C31C932A114644B3EDEA420401D6CA6924A1DB7AC60C044B194320A39750C300C12965832CC001EB8F1C826710D746572512844451543A841C20703D13203396E0E600519421232CD00C8F832401B0205C5D00656B0E9CD145EC0D040200D38728A16042CFF5007060D58096333A42C540D6E2484F04F08B7A4828C1C3444534412451CB00626415402812FC8F4F3CF16A22614821C02C891CF1115D0128B1E1674A12211EA4832400AE40441D036B702A290024D48C1083E8D7CF32616A02C62510EFFE450404507C4C00332CE90F1CF3C5D26548431026010C406391C63801E1A5820012B1C906007022BDC822E28045D025E276F20944B3C2AA8C2890AA83C02C1263EF023422BAC88F0CF04AC3C310F0A1480324D2ACE480B1242CCDC22C03001F8E0CA3F5D18D18A2CAF48204A00CB04F08F2C6DCC91821C071014C9C8251B64430744FC23CD000B0C41C00E9012E3B426FCE0FC040ACC5C21411B56A452820BFF24FF6C503FA90C00C906FFC4B24831162C22011E12E850450254102341310D0C238022821024C6C89328400A3786A9E2072ADBFC334309022881CD101724A1CA2B8BF8538006CCF8F044015FFC73450CDE9430801E085500411D596C7085052F1890490E8618718C1E1F60C3860E12300D87090C5FA63978E3342120019D93A04228BBD4818C37BBCC4384DA83B8B3812CFF14104C052288A34A0E16F031C3B37A1DF4432A3C38021F8A81BFE4E961167D10810EB60185165CE11FB3F8C33F92400801F0606803D95C13E8D1082924401DBF68421EE84182472CA010C7A0822A18800D4610E106E638822D8A00872EA8A2001310042B1A708B1278A35A0231C000FF04908F0ABC201CB1C8C12BFE61005AC820071FB8400420D5073408C2021A808131529008835403007960874016C1060048210200E0103E48E0063F70A30F74C04719CA310A3998C366399845CE98C10C3298AF6B05498200C80189456422138BB0471788F10F14B4A016A050C1031A60013448C00239D8822DAC2080761CE41A69CC86062A00860754C01D6A7A4023ECF0C126804F0543C0073904E005DDCD82125CF8C317FC31067238231A0681013286E18262144310DFA2C01F66B1864470C08396C8401226F08770848315695885003280106B00E01E96C0822224618218D4C118A7D8450578D1807694C30E208002081EF18052B4E1065C80832CF470FF1A170CC0173F3048294A300D2074E10B13B080052600875A0081059280C21D5280817AF4A20B22F0171A6A50074524A4104FC202186A4008329420053068051FF5300F2A88220C33B88737EE608E680001085FF84217BAE00F208CA2045830C82990010B5B10841F48DD402D6001817B280203BE1244010AE02F7894A20EC3188F410441832C2801031850823046810C0800C120C5604118B270877B68C157693092400EF0532B0814194A1841178E210209488018AF108210A680D50640421057482C62AF4081ABF2C06F04414106F2010B0C9C2A1F032881318E600462EC540413A8872358508A5528620C8198451712D1D72E48C0A7BE98433053A10806FFFCE39839F8421F64D007658C400B8148843284E0093C88E0B89AE0C20F52879070D0601596C0451C5650031EA40202A0DAC2C428B1817AB4C0112680C129CC0107216C40AF2228C00B1A300067D0C020BC10803702308183F661160AFD471F4670DE0AFCC30286D0003132CA8F226081880931C134A0810B4554025F6C7204CF9EC005437CE11894A8040D6A500913D8E30F40D8001C2630812F9C821CBE006641F4208714B4831205B040012490BB1C98F71F32E042972CE08A4CB8A200C468C028EA00328418E007B8B0C234CCE0ABCCD2E07613C8C122FF01845B80820240C88223D600871C188002BAA00416EA2000FF1A6415A9C8C00844508C5DFEE3FF92F530C47FB990892DBC40C67A30401A6AB0350A288417481086096C618F70E4C37723D0C43F5E913B56AC6015A7F982215EC12F8C6E410FA018985D0F7280AD99C007C750B4387A81064F18E11FFE30442FC2510C7E58E00A06C09B0066B0905210A24B0678022D80E00D39FCA0027D80C3169E108C5128822A08D58006144D8C0250C20C104006A8105289D4054003FFF5072BB8A089DC7D81029E10041F5E70053CD8220B2930860F14620F24D4B2206440863160B0816060A2089838841578F10F0D88000E5754B406C630B0430091206968713E18F00709E82218FEC82DD35861043C148325B6D0821CEAF06E843C611D5658012B0A420B7294E01021FFA00533B6408B60B0C2CF1328803F28F0822EA0011415AC431116D2067465E10828408301BE2073A6C5A21522E047385CE0056F6CF3E00461860B36608B831F4100C8B002D09F90EB17B0640257F8C2C47CC08229A400192A5E48345200013204A008ADC89DCDF0F08F701820110DC8C210E7C00C8F444300BE3341089E60918EF8E3660E6080233250875494E221E630065681E10279F8001E0640C31342D0002DCC617895E8FB491AF02C014C2306CFD8C31AF6D0024C30200833C86C1DD2EE9035C0A20E291845067E100348AC001864E00104B2E508B454E067CE488531AC50094C296114102801320EB1F389B481A96B8280F6D594A71F14CA2E6D89B6412F7C5182F1FBA20E73E05BDF22F2822E6D81175EC840376ED18D39AC0214AB593F5A2CF40F5A80A21F531080ABE005BCA007ACC00AB1606721B2800CD880091110003B, N'superlight_red_small.gif', N'bc621e1f-2553-4fdc-b22e-5e44a9003569', CAST(N'2008-03-11T10:01:36.827' AS DateTime))
INSERT expected ([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]) VALUES (750, N'Road-150 Red, 44', N'BK-R93R-44', N'Red', 2171.2942, 3578.2700, N'44', CAST(6245.93 AS Decimal(8, 2)), 6, 25, CAST(N'2005-07-01T00:00:00.000' AS DateTime), CAST(N'2006-06-30T00:00:00.000' AS DateTime), @currDate, 0x47494638396150003100F70000920407C6BCC339343A585459D0162DF9F9FDF9F9F9DCDBDBDBE4E8A92E37F978885B2129D3CACEC4C1C5F9EBEC876A6F484349A8454DF4F4FAEDEDF5F1F1F1E3E3E4EEEDF8C66A76665D64837D83F0EEF4E0DEE4BDC5CEE7000F70859FE9F3F6A03946D4D2D4F5F5FCCCC9D5CD354F2A242AB2ADB2FEF3F6EEEDED433D43C12432B5B1B2B8B6C1D3D2DBCDCACBFEFEFEBDBBBDB1AAADE3E1F4928E91929193A5A2A5FDDCDECCCFD9E8CACAF7F7FCF3FBFEC69AAE6B656CFD8892E9E7E89D9A9DD0CED2BAB3B5DCDAEDC80005CA7683DFDDDEF1F1F6C9C5CB6C6C77DDDCE07D757AFB6779F82B46B70016A60115F0EFEFA51E24FDA2A9B062678B898CF9FEFED48A8B716D72FBFCFE7F7C809A9499A9A4ADFCFCFCE4E3EAF3F2FAACAAACF0F0F8A89B9CACB2B5DAA9A9ABA8B188848AFA56698A8B92C14C57EEEEF1E9E9EAE40024E2E0DDB98E92C6C5C5D8536FFDC8C9E9E8EE5B5963544E53747274CB83863D393FA9565E894C56F2F1FDC20113F7F6F7E8E4E1F5F4F5E8E6F3FB98A2EDEBF2FDB6B9C5C3CCFCFBFCCBA1A6828086AB8E98EBEAF26D696BBB0005DAD7DE726A6FF3F2F3D10315BC808CB5B3B98A1628BDB5BCDEB5B46E737BE74561EDEAED88838574747EE0BABADED9D6F6F4F5F4F3F98F9598EBD4D3ED1436EAE8F6E4D2D1C2BEC1F8F1F0F5F9F7635F64FDA9B3A6A6A82C32409E9EA0D60009322E32FDFFFE908D8EF8F7F7F7F6F4F6F4F8F0EFFB7C797DFBFAFAF2F2F7ECEAF5EBEAEBD5D2E1D7D5D76763677E808BFFFEFDFCFCFAE1E9E9D8D9D9F2F0F9242024A40003A39DA2EDECEB97949768626BF2F1FAFDFDFD4F4B50F4F3FD2E292DF61937DAD7E6BD1422F5F5F5EF082B211C1FD6D0C89FA0AAB7B7B7F3F6F8797378EFDCDCDA9DA2C58B8ECE9596C33B3DE24D78E25A66DEC0C1FED3DF68696A60595F4D5457334962F6F5F5F0F2FAE1003750454DA07D88BFC0C4EEAEB49BA9C1869DC59F1115ACA8A7F1507BADA2A8D4E1E7FA3E57EBECEFF9273FE3D7DAF9FBFBDD1E48DFDEEDF4F3F27F3847CD0C1E97909696999DC0D3E0FDFDFF999999F1F1F8FFFFFF21F90400000000002C00000000500031000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710234A5CC8ECC9C48B18257AC1C227A3C02D05AF88BBA1AF9847894506F058E4B101162C66689C4297CE03B85327236EA15102C39C53262F1A48D2C69C2401A692E2CC0931960B08290ED5B097D3450A452656309D38236A3E13AB56B1C4086A45C7AD13EDF1320004960008B430B20AB206EDC91502C264AC506AACDD894638A85876EE04C66835FE627457A883E36465A2D888586C140CC513E7ED3BD301448226433A347BD7E34DAC86BB7804C32C71020B0288B4B5FA642D821344A8D4305902C841420752DA89621DD15D23544ED49419B867901D28884243F633B92020548D8843BCB28F042200C997E4FF2218EAD285CFA1472B7863F89F024638B43FFC6082D12F285000A8597250100E3A50FC9207236AC4B304294CA8309C7C0DB973C17738500345720AA8821035D820924713A0A9A1C6050C1A4441112EB401C401B41820D82F6208C4893AC9F590503155E0A3861B1710C048240751E0420DAB903185302BD4E5D11330CC30C728710C10471CA398B1C310551084038C6AF861902A2F08F40936A82C31C932A114644B3EDEA420401D6CA6924A1DB7AC60C044B194320A39750C300C12965832CC001EB8F1C826710D746572512844451543A841C20703D13203396E0E600519421232CD00C8F832401B0205C5D00656B0E9CD145EC0D040200D38728A16042CFF5007060D58096333A42C540D6E2484F04F08B7A4828C1C3444534412451CB00626415402812FC8F4F3CF16A22614821C02C891CF1115D0128B1E1674A12211EA4832400AE40441D036B702A290024D48C1083E8D7CF32616A02C62510EFFE450404507C4C00332CE90F1CF3C5D26548431026010C406391C63801E1A5820012B1C906007022BDC822E28045D025E276F20944B3C2AA8C2890AA83C02C1263EF023422BAC88F0CF04AC3C310F0A1480324D2ACE480B1242CCDC22C03001F8E0CA3F5D18D18A2CAF48204A00CB04F08F2C6DCC91821C071014C9C8251B64430744FC23CD000B0C41C00E9012E3B426FCE0FC040ACC5C21411B56A452820BFF24FF6C503FA90C00C906FFC4B24831162C22011E12E850450254102341310D0C238022821024C6C89328400A3786A9E2072ADBFC334309022881CD101724A1CA2B8BF8538006CCF8F044015FFC73450CDE9430801E085500411D596C7085052F1890490E8618718C1E1F60C3860E12300D87090C5FA63978E3342120019D93A04228BBD4818C37BBCC4384DA83B8B3812CFF14104C052288A34A0E16F031C3B37A1DF4432A3C38021F8A81BFE4E961167D10810EB60185165CE11FB3F8C33F92400801F0606803D95C13E8D1082924401DBF68421EE84182472CA010C7A0822A18800D4610E106E638822D8A00872EA8A2001310042B1A708B1278A35A0231C000FF04908F0ABC201CB1C8C12BFE61005AC820071FB8400420D5073408C2021A808131529008835403007960874016C1060048210200E0103E48E0063F70A30F74C04719CA310A3998C366399845CE98C10C3298AF6B05498200C80189456422138BB0471788F10F14B4A016A050C1031A60013448C00239D8822DAC2080761CE41A69CC86062A00860754C01D6A7A4023ECF0C126804F0543C0073904E005DDCD82125CF8C317FC31067238231A0681013286E18262144310DFA2C01F66B1864470C08396C8401226F08770848315695885003280106B00E01E96C0822224618218D4C118A7D8450578D1807694C30E208002081EF18052B4E1065C80832CF470FF1A170CC0173F3048294A300D2074E10B13B080052600875A0081059280C21D5280817AF4A20B22F0171A6A50074524A4104FC202186A4008329420053068051FF5300F2A88220C33B88737EE608E680001085FF84217BAE00F208CA2045830C82990010B5B10841F48DD402D6001817B280203BE1244010AE02F7894A20EC3188F410441832C2801031850823046810C0800C120C5604118B270877B68C157693092400EF0532B0814194A1841178E210209488018AF108210A680D50640421057482C62AF4081ABF2C06F04414106F2010B0C9C2A1F032881318E600462EC540413A8872358508A5528620C8198451712D1D72E48C0A7BE98433053A10806FFFCE39839F8421F64D007658C400B8148843284E0093C88E0B89AE0C20F52879070D0601596C0451C5650031EA40202A0DAC2C428B1817AB4C0112680C129CC0107216C40AF2228C00B1A300067D0C020BC10803702308183F661160AFD471F4670DE0AFCC30286D0003132CA8F226081880931C134A0810B4554025F6C7204CF9EC005437CE11894A8040D6A500913D8E30F40D8001C2630812F9C821CBE006641F4208714B4831205B040012490BB1C98F71F32E042972CE08A4CB8A200C468C028EA00328418E007B8B0C234CCE0ABCCD2E07613C8C122FF01845B80820240C88223D600871C188002BAA00416EA2000FF1A6415A9C8C00844508C5DFEE3FF92F530C47FB990892DBC40C67A30401A6AB0350A288417481086096C618F70E4C37723D0C43F5E913B56AC6015A7F982215EC12F8C6E410FA018985D0F7280AD99C007C750B4387A81064F18E11FFE30442FC2510C7E58E00A06C09B0066B0905210A24B0678022D80E00D39FCA0027D80C3169E108C5128822A08D58006144D8C0250C20C104006A8105289D4054003FFF5072BB8A089DC7D81029E10041F5E70053CD8220B2930860F14620F24D4B2206440863160B0816060A2089838841578F10F0D88000E5754B406C630B0430091206968713E18F00709E82218FEC82DD35861043C148325B6D0821CEAF06E843C611D5658012B0A420B7294E01021FFA00533B6408B60B0C2CF1328803F28F0822EA0011415AC431116D2067465E10828408301BE2073A6C5A21522E047385CE0056F6CF3E00461860B36608B831F4100C8B002D09F90EB17B0640257F8C2C47CC08229A400192A5E48345200013204A008ADC89DCDF0F08F701820110DC8C210E7C00C8F444300BE3341089E60918EF8E3660E6080233250875494E221E630065681E10279F8001E0640C31342D0002DCC617895E8FB491AF02C014C2306CFD8C31AF6D0024C30200833C86C1DD2EE9035C0A20E291845067E100348AC001864E00104B2E508B454E067CE488531AC50094C296114102801320EB1F389B481A96B8280F6D594A71F14CA2E6D89B6412F7C5182F1FBA20E73E05BDF22F2822E6D81175EC840376ED18D39AC0214AB593F5A2CF40F5A80A21F531080ABE005BCA007ACC00AB1606721B2800CD880091110003B, N'superlight_red_small.gif', N'c19e1136-5da4-4b40-8758-54a85d7ea494', CAST(N'2008-03-11T10:01:36.827' AS DateTime))
INSERT expected ([ProductID], [Name], [ProductNumber], [Color], [StandardCost], [ListPrice], [Size], [Weight], [ProductCategoryID], [ProductModelID], [SellStartDate], [SellEndDate], [DiscontinuedDate], [ThumbNailPhoto], [ThumbnailPhotoFileName], [rowguid], [ModifiedDate]) VALUES (706, N'Should not Update', N'BK-R93R-77', N'Red', 1059.3100, 1431.5000, N'58', CAST(1016.04 AS Decimal(8, 2)), 18, 6, CAST(N'2002-06-01T00:00:00.000' AS DateTime), NULL, NULL, 0x47494638396150003100F70000000000800000008000808000000080800080008080808080C0C0C0FF000000FF00FFFF000000FFFF00FF00FFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000330000660000990000CC0000FF0033000033330033660033990033CC0033FF0066000066330066660066990066CC0066FF0099000099330099660099990099CC0099FF00CC0000CC3300CC6600CC9900CCCC00CCFF00FF0000FF3300FF6600FF9900FFCC00FFFF3300003300333300663300993300CC3300FF3333003333333333663333993333CC3333FF3366003366333366663366993366CC3366FF3399003399333399663399993399CC3399FF33CC0033CC3333CC6633CC9933CCCC33CCFF33FF0033FF3333FF6633FF9933FFCC33FFFF6600006600336600666600996600CC6600FF6633006633336633666633996633CC6633FF6666006666336666666666996666CC6666FF6699006699336699666699996699CC6699FF66CC0066CC3366CC6666CC9966CCCC66CCFF66FF0066FF3366FF6666FF9966FFCC66FFFF9900009900339900669900999900CC9900FF9933009933339933669933999933CC9933FF9966009966339966669966999966CC9966FF9999009999339999669999999999CC9999FF99CC0099CC3399CC6699CC9999CCCC99CCFF99FF0099FF3399FF6699FF9999FFCC99FFFFCC0000CC0033CC0066CC0099CC00CCCC00FFCC3300CC3333CC3366CC3399CC33CCCC33FFCC6600CC6633CC6666CC6699CC66CCCC66FFCC9900CC9933CC9966CC9999CC99CCCC99FFCCCC00CCCC33CCCC66CCCC99CCCCCCCCCCFFCCFF00CCFF33CCFF66CCFF99CCFFCCCCFFFFFF0000FF0033FF0066FF0099FF00CCFF00FFFF3300FF3333FF3366FF3399FF33CCFF33FFFF6600FF6633FF6666FF6699FF66CCFF66FFFF9900FF9933FF9966FF9999FF99CCFF99FFFFCC00FFCC33FFCC66FFCC99FFCCCCFFCCFFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF21F90401000010002C00000000500031000008FF00FF091C48B0A0C18308132A5CC8B0A1C38710234A9C48B1A2C58B18336ADCC8B1A3C78F20438A1C49B2A4C9932853AA5C9911058A812E17C664F9D0E5CB7F3313E6A4C9D0A6C099366FC27C19D367CEA04371DE44CA1169D1A542952A25FA1467D2A7547F46C558542AD0A855A58A9D9AD52BD4A654C3EE547BD6AC58AC3E377E2DBB96EED9AF6FCB7A9C9B97205BAD7DB1F6952B74EED6BF79E3B2DDC95362E1AD8D2F328D4CB9B2E5CB9831C77518D62063C6223743040DD82F6490558FA6BD0B152F5EB2A8B3AA7EEC96B651D96D3BFE9D8D7BE86EBB1F7F034ECD3AF06AD292831237EEB6F9F290AAB5B65DEE9A7A6EC249A7FA7EAEDC79EBD399C38B121F4FBEBCF9F3E8D3AB5FCFBEBDFBF7EF0302003B, N'no_image_available_small.gif', N'9540ff17-2712-4c90-a3d1-8ce5568b2462', CAST(N'2008-03-11T10:01:36.827' AS DateTime))

      SELECT  *
		INTO actual
		FROM [SalesLT].[Product];

------Assertion
    EXEC tSQLt.AssertEqualsTable Expected, Actual ;
END;
GO