

write-host " How can I help you?"
Write-Host "A) Collect new baseline?"
Write-Host "B) Begin monitoring files with saved baseline?" 

$response = read-host -Prompt "Please enter 'A' or 'B'"



Function Calculate-File-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

 Function Erase-Baseline-If-Already-Exists(){
 $baselineExists = Test-Path -Path .\baseline.txt
    
    if($baselineExists) {
    #delete 
    Remove-Item -Path .\baseline.txt
    } 
 }
if ($response -eq "A".ToUpper()) {
    # Calculate hash from the target files and store in baseline.txt
    Write-host "calculate Hashes, make new baseline.txt" -ForegroundColor Red
    #get hashes in target file and store in baseline.txt 

    #delete baseline if it already exists
    Erase-Baseline-If-Already-Exists
   
    #collect all filse ini the target folder
    $files = Get-ChildItem -Path .\
    
    #for each file calculate the hash and write to baseline.txt
   foreach ($f in $files) { 
        $hash= Calculate-File-Hash $f.FullName
        "$($hash.Path)|$($hash.Hash)"| Out-file -FilePath .\baseline.txt -Append
   }

}
elseif ($response -eq "B".ToUpper()) {

   $fileHashDictionary = @{}
    
    #load file hash from baseline.tct and store then in a dictionary 
    $filesPathesAndHashes = Get-Content -Path .\baseline.txt
    
    foreach ($f in $filesPathesAndHashes) {
       $fileHashDictionary.Add($f.Split("|")[0],$f.Split("|")[1])
    }
    
    
   
   
    

    #Begin monitoring (continously) files with saved Baseline
    while ($true) {
    Start-Sleep -Seconds 1
  
  
   $files = Get-ChildItem -Path .\
    
    #for each file calculate the hash and write to baseline.txt
   foreach ($f in $files) { 
        $hash= Calculate-File-Hash $f.FullName
        #"$($hash.Path)|$($hash.Hash)"| Out-file -FilePath .\baseline.txt -Append

        #notify if new file is created
        if ($fileHashDictionary[$hash.Path] -eq $null) {
        #A NEW FILE IS CREATED
        Write-Host "$($hash.Path) has been created!" -ForegroundColor Green
        
        }

        #notify file has been changed
        if ($fileHashDictionary[$hash.Path] -eq $hash.Hash) {
        #file has not changed
        }
        else {
        #file has been compromised
        Write-Host "$($hash.Path) has changed!! RED ALERT" -ForegroundColor Red
        }
   }

    }

     foreach ($key in $fileHashDictionary.Keys) {
            $baselineFileStillExists = Test-Path -Path $key
            if (-Not $baselineFileStillExists) {
                # One of the baseline files must have been deleted, notify the user
                Write-Host "$($key) has been deleted!" -ForegroundColor DarkRed -BackgroundColor Gray
            }
        }
    }
}
    