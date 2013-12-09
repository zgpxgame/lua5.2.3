@rem Script to build Lua under "Visual Studio .NET Command Prompt".
@rem Do not run from this directory; run it from the toplevel: etc\luavs.bat .
@rem It creates lua51.dll, lua51.lib, lua.exe, and luac.exe in src.
@rem (contributed by David Manura and Mike Pall)

@setlocal
@set MYCOMPILE=cl /nologo /Zi /MD /Od /W3 /c /D_CRT_SECURE_NO_DEPRECATE
@set MYLINK=link /nologo /DEBUG 
@set MYMT=mt /nologo

cd src
%MYCOMPILE% /DLUA_BUILD_AS_DLL l*.c
del lua.obj luac.obj
%MYLINK% /DLL /PDB:lua5.2.pdb /out:lua5.2.dll l*.obj
if exist lua5.2.dll.manifest^
  %MYMT% -manifest lua5.2.dll.manifest -outputresource:lua5.2.dll;2
%MYCOMPILE% /DLUA_BUILD_AS_DLL lua.c
%MYLINK% /out:lua.exe /PDB:lua.pdb lua.obj lua5.2.lib
if exist lua.exe.manifest^
  %MYMT% -manifest lua.exe.manifest -outputresource:lua.exe
%MYCOMPILE% l*.c
del lua.obj
%MYLINK% /out:luac.exe /PDB:luac.pdb *.obj
if exist luac.exe.manifest^
  %MYMT% -manifest luac.exe.manifest -outputresource:luac.exe
del *.obj *.manifest
cd ..
