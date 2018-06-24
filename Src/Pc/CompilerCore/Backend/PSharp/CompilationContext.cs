﻿using Microsoft.Pc.TypeChecker;
using Microsoft.Pc.TypeChecker.AST.Declarations;

namespace Microsoft.Pc.Backend.PSharp
{
    class CompilationContext : CompilationContextBase
    {
        private ITranslationErrorHandler handler;
        private ICompilerOutput log;
        private string projectName;

        public NameManager Names { get; }

        public CompilationContext(ITranslationErrorHandler handler, ICompilerOutput log, string projectName)
            : base(handler, projectName)
        {
            this.handler = handler;
            this.log = log;
            this.projectName = projectName;
            this.Names = new NameManager("PGEN_");

            FileName = $"{projectName}.cs";
            GlobalFunctionClassName = $"GlobalFunctions_{projectName}";
        }

        public string GetStaticMethodQualifiedName(Function function)
        {
            return $"{GlobalFunctionClassName}.{Names.GetNameForNode(function)}";
        }

        public string GlobalFunctionClassName { get; }

        public string FileName { get; internal set; }
    }
}