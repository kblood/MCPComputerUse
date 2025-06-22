using System;

namespace ModelContextProtocol.Server
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
    public class McpServerToolAttribute : Attribute
    {
        public string Name { get; }
        public McpServerToolAttribute(string name)
        {
            Name = name;
        }
    }

    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
    public class McpServerToolTypeAttribute : Attribute
    {
        public McpServerToolTypeAttribute() { }
    }
}
