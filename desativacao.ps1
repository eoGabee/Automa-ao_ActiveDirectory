#Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
#Execute no PowerShell com permissões de administrador:

Import-Module ActiveDirectory
Import-Csv "C:\caminho\usuarios_ferias.csv" | ForEach-Object { #a cada linha do arquivo csv...#
    $user = Get-ADUser -Identity $_.Username #$_ representa a linha atual do CSV
                                             #$user representa o usuario que foi tirado da lista
    if ($user) {
        # Define a data de expiração da conta
        Set-ADUser -Identity $_.Username -AccountExpirationDate ([datetime]::Parse($_.EndDate))
        # Desativa a conta manualmente se desejar
        Disable-ADAccount -Identity $_.Username
        Write-Host "Usuário $($_.Username) desativado até $($_.EndDate)"
    } else {
        Write-Host "Usuário $($_.Username) não encontrado."
    }
}
