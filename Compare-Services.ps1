function Compare-Services ($ReferenceComputer, $DifferenceComputer, [switch]$FriendlyText) {
 
$ReferenceServices = (Get-Service -ComputerName $ReferenceComputer | where Status -EQ "Running").DisplayName
$DifferenceServices = (Get-Service -ComputerName $DifferenceComputer | where Status -EQ "Running").DisplayName
 
$CompareResult = Compare-Object -ReferenceObject $ReferenceServices -DifferenceObject $DifferenceServices
 
if ($FriendlyText) {
    $CompareResult | foreach {
        if ($_.SideIndicator -eq "=>") {"`"$($_.InputObject)`" is on $DifferenceComputer (not on $ReferenceComputer)"}
        if ($_.SideIndicator -eq "<=") {"`"$($_.InputObject)`" is on $ReferenceComputer (not on $DifferenceComputer)"}
        }
    }
    else {$CompareResult}
}
