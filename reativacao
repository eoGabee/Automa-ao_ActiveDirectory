#Script para reativar usuários no dia de retorno
#Esse script pode ser colocado em uma tarefa agendada diária:

$hoje = Get-Date

Get-ADUser -Filter * -Properties AccountExpirationDate, Enabled | Where-Object {
    $_.AccountExpirationDate -and ($_.AccountExpirationDate.Date -le $hoje.Date) -and (-not $_.Enabled)
} | ForEach-Object {
    Enable-ADAccount -Identity $_.SamAccountName
    Set-ADUser -Identity $_.SamAccountName -AccountExpirationDate $null
    Write-Host "Usuário $($_.SamAccountName) reativado."
}
