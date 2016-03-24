// HtmlAgilityPack V1.0 - Simon Mourier <simon_mourier@hotmail.com>
using System;

namespace HtmlAgilityPack
{
    internal class NameValuePair
    {
        internal readonly string Name;
        internal string Value;

        internal NameValuePair()
        {
        }

        internal NameValuePair(string name)
            :
            this()
        {
            Name = name;
        }

        internal NameValuePair(string name, string value)
            :
            this(name)
        {
            Value = value;
        }
    }

}
