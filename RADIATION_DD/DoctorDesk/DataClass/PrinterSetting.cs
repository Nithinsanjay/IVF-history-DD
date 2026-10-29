//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;

//namespace WEBJUPHMIS.DataClass
//{
//    public class PrinterSetting
//    {
//    }
//}

using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Drawing.Printing;
using System.Runtime.InteropServices;

namespace WEBJUPHMIS.DataClass
{
    public class PrinterSetting
    {
        //private void SendFileToPrinterandSendBytesToPrinter()
        //{
        //   System.IO OpenFileDialog ofd = new OpenFileDialog();
        //    if (ofd.ShowDialog(this))
        //    {
        //        // Allow the user to select a printer.
        //        PrintDialog pd = new PrintDialog();
        //        pd.PrinterSettings = new PrinterSettings();
        //        if ((pd.ShowDialog() == DialogResult.OK))
        //        {
        //            //RawPrinterHelper.SendFileToPrinter(pd.PrinterSettings.PrinterName, ofd.FileName)
        //        }
        //    }
        //}

        //private void SendBytesToPrinter()
        //{
        //    string s = null;
        //    PrintDialog pd = new PrintDialog();
        //    s = "Hello, this is a test";
        //    // Open the printer dialog box, and then allow the user to select a printer.
        //    pd.PrinterSettings = new PrinterSettings();
        //    if ((pd.ShowDialog() == DialogResult.OK))
        //    {
        //        //RawPrinterHelper.SendStringToPrinter(pd.PrinterSettings.PrinterName, s)
        //    }
        //}
        // Button2_Click()

        // Structure and API declarions:
        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
        public struct DOCINFOW
        {
            [MarshalAs(UnmanagedType.LPWStr)]
            public string pDocName;
            [MarshalAs(UnmanagedType.LPWStr)]
            public string pOutputFile;
            [MarshalAs(UnmanagedType.LPWStr)]
            public string pDataType;
        }
        //StdCall
        [DllImport("winspool.Drv", EntryPoint = "OpenPrinterW", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool OpenPrinter(string src, ref IntPtr hPrinter, long pd);

        [DllImport("winspool.Drv", EntryPoint = "ClosePrinter", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool ClosePrinter(IntPtr hPrinter);

        [DllImport("winspool.Drv", EntryPoint = "StartDocPrinterW", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool StartDocPrinter(IntPtr hPrinter, Int32 level, ref DOCINFOW pDI);

        [DllImport("winspool.Drv", EntryPoint = "EndDocPrinter", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool EndDocPrinter(IntPtr hPrinter);
        [DllImport("winspool.Drv", EntryPoint = "StartPagePrinter", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool StartPagePrinter(IntPtr hPrinter);

        [DllImport("winspool.Drv", EntryPoint = "EndPagePrinter", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool EndPagePrinter(IntPtr hPrinter);

        [DllImport("winspool.Drv", EntryPoint = "WritePrinter", SetLastError = true, CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
        public static extern bool WritePrinter(IntPtr hPrinter, IntPtr pBytes, Int32 dwCount, ref Int32 dwWritten);

        public static bool SendBytesToPrinter(string szPrinterName, IntPtr pBytes, Int32 dwCount)
        {
            IntPtr hPrinter = default(IntPtr);
            // The printer handle.
            Int32 dwError = default(Int32);
            // Last error - in case there was trouble.
            DOCINFOW di = default(DOCINFOW);
            // Describes your document (name, port, data type).
            Int32 dwWritten = default(Int32);
            // The number of bytes written by WritePrinter().
            bool bSuccess = false;
            // Your success code.

            // Set up the DOCINFO structure.
            var _with1 = di;
            _with1.pDocName = "My Visual Basic .NET RAW Document";
            _with1.pDataType = "RAW";
            
            // Assume failure unless you specifically succeed.
            bSuccess = false;
            try
            {
                OpenPrinter(szPrinterName, ref hPrinter, 0);
            }   
            catch
            {

            }
            //if (OpenPrinter(szPrinterName, ref hPrinter, 0))
            //{
                if (StartDocPrinter(hPrinter, 1, ref di))
                {
                    if (StartPagePrinter(hPrinter))
                    {
                        // Write your printer-specific bytes to the printer.
                        bSuccess = WritePrinter(hPrinter, pBytes, dwCount, ref dwWritten);
                        EndPagePrinter(hPrinter);
                    }
                    EndDocPrinter(hPrinter);
                }
                ClosePrinter(hPrinter);
          // }
            // If you did not succeed, GetLastError may give more information
            // about why not.
            if (bSuccess == false)
            {
                dwError = Marshal.GetLastWin32Error();
            }
            return bSuccess;
        }

        public static bool SendFileToPrinter(string szPrinterName, string szFileName)
        {
            FileStream fs = new FileStream(szFileName, FileMode.Open);
            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = new byte[fs.Length + 1];
            bool bSuccess = false;
            IntPtr pUnmanagedBytes = default(IntPtr);
            bytes = br.ReadBytes(Convert.ToInt16(fs.Length));
            pUnmanagedBytes = Marshal.AllocCoTaskMem(Convert.ToInt16(fs.Length));
            Marshal.Copy(bytes, 0, pUnmanagedBytes, Convert.ToInt16(fs.Length));
            bSuccess = SendBytesToPrinter(szPrinterName, pUnmanagedBytes, Convert.ToInt16(fs.Length));
            Marshal.FreeCoTaskMem(pUnmanagedBytes);
            return bSuccess;
        }

        public void SendStringToPrinter(string szPrinterName, string szString)
        {
            IntPtr pBytes = default(IntPtr);
            Int32 dwCount = default(Int32);
            dwCount = Convert.ToInt32(szString.Length);
            pBytes = Marshal.StringToCoTaskMemAnsi(szString);
            SendBytesToPrinter(szPrinterName, pBytes, dwCount);
            Marshal.FreeCoTaskMem(pBytes);
        }
    }
}

