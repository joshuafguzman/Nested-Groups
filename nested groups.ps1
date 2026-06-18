# 1. Pull only the MemberOf properties of all groups to find relationships
$AllNestedGroups = Get-ADGroup -Filter * -Properties MemberOf | Where-Object { $_.MemberOf }

# 2. Extract parent DistinguishedNames and filter for those starting with CN=Gr_
$ParentDNs = $AllNestedGroups.MemberOf | Where-Object { $_ -like "CN=Gr_*" } | Select-Object -Unique

# 3. Fetch the group objects for those specific parents
$ParentDNs | ForEach-Object {
    Get-ADGroup -Identity $_
} | Select-Object Name, DistinguishedName