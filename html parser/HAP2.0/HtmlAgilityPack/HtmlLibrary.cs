// HtmlAgilityPack V1.0 - Simon Mourier <simon_mourier@hotmail.com>
using System;
using System.Diagnostics;

namespace HtmlAgilityPack
{
    internal struct HtmlLibrary
    {
        //[Conditional("DEBUG")]
        //internal static void GetVersion(out string version)
        //{
        //    System.Diagnostics.StackFrame sf = new System.Diagnostics.StackFrame(1, true);
        //    version = sf.GetMethod().DeclaringType.Assembly.GetName().Version.ToString();
        //}

        //[Conditional("DEBUG")]
        //[Conditional("TRACE")]
        //internal static void Trace(object Value)
        //{
        //    // category is the method
        //    string name = null;
        //    GetCurrentMethodName(2, out name);
        //    System.Diagnostics.Trace.WriteLine(Value, name);
        //}

        //[Conditional("DEBUG")]
        //[Conditional("TRACE")]
        //internal static void TraceStackFrame(int steps)
        //{
        //    string name = null;
        //    GetCurrentMethodName(2, out name);
        //    string trace = "";
        //    for (int i = 1; i < steps; i++)
        //    {
        //        System.Diagnostics.StackFrame sf = new System.Diagnostics.StackFrame(i, true);
        //        trace += sf.ToString();
        //    }
        //    System.Diagnostics.Trace.WriteLine(trace, name);
        //    System.Diagnostics.Trace.WriteLine("");
        //}

        //[Conditional("DEBUG")]
        //internal static void GetCurrentMethodName(out string name)
        //{
        //    name = null;
        //    GetCurrentMethodName(2, out name);
        //}

        //[Conditional("DEBUG")]
        //internal static void GetCurrentMethodName(int skipframe, out string name)
        //{
        //    StackFrame sf = new StackFrame(skipframe, true);
        //    name = sf.GetMethod().DeclaringType.Name + "." + sf.GetMethod().Name;
        //}

    }

}
