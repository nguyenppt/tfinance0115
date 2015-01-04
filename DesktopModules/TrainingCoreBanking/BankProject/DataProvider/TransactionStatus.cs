﻿namespace BankProject.DataProvider
{
    public static class TransactionStatus
    {
        public const string UNA = "UNA";//Unauthorized : Chờ duyệt
        public const string DEL = "DEL";//Delete : Xóa, không duyệt
        public const string AUT = "AUT";//Authorized : Đã duyệt
        public const string RNAU = "RNAU";//Unauthorized reverse : Chờ duyệt reverse
        public const string REV = "REV";//Reversed : Đã reverse
        public const string HLD = "HLD";//Hold
    }
}