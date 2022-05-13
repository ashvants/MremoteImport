#Set the average time to your system load and open an iexplorer page
#Start-Sleep -Seconds 60

Add-Type -AssemblyName System.Windows.Forms



[system.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
$myshell = New-Object -com "Wscript.Shell"

# Set the exactly position of cursor in some iexplore hyperlink between the (open parenthesis) below: 
#[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(558,336)

function Click-MouseButton
{
    $signature=@' 
      [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
      public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@ 

    $SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru 

        $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
        $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
}


[array] $Vowels = "a;a;a;a;e;e;e;e;i;i;i;o;o;o;u;u;y" -split ";"
[array] $Consonants = "b;b;br;c;c;c;ch;cr;d;f;g;h;j;k;l;m;m;m;n;n;p;p;ph;qu;r;r;r;s;s;s;sh;t;tr;v;w;x;z" -split ";"
[array] $Endings = "r;r;s;r;l;n;n;n;c;c;t;p" -split ";" 

#
# Functions for random vowels, consonants, endings and words
# 

function Get-RandomVowel 
{ return $Vowels[(Get-Random($Vowels.Length))] } 

function Get-RandomConsonant
{ return $Consonants[(Get-Random($Consonants.Length))] } 

function Get-RandomEnding
{ return $Endings[(Get-Random($Endings.Length))] } 

function Get-RandomSyllable ([int32] $PercentConsonpiobeants, [int32] $PercentEndings)
{  
   [string] $Syllable = ""
   if ((Get-Random(100)) -le $PercentConsonants) 
   { $Syllable+= Get-RandomConsonant }
   $Syllable+= Get-RandomVowel
   if ((Get-Random(100)) -le $PercentEndings) 
   { $Syllable+= Get-RandomEnding }
   return $Syllable
} 

function Get-RandomWord ([int32] $MinSyllables, [int32] $MaxSyllables)
{  
   [string] $Word = ""
   [int32] $Syllables = ($MinSyllables) + (Get-Random(($MaxSyllables - $MinSyllables + 1)))
   for ([int32] $Count=1; $Count -le $Syllables; $Count++) 
   { $Word += Get-RandomSyllable 70 20 } <# Consonant 70% of the time, Ending 20% #>
   return $Word
} 





$timeout = new-timespan -Minutes 6000
$sw = [diagnostics.stopwatch]::StartNew()
$i=0
$slep = 5

while ($sw.elapsed -lt $timeout){

Start-Sleep -seconds $slep

$i++


[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(1579,906)
Click-MouseButton
#$word = Get-RandomWord 2 3 
#$myshell.sendkeys("$word")


Write-Host "Mouse Clicked - elasped $($sw.elapsed) - counter $i"

#    if (test-path c:\testfiles\somefile.txt){
 #       write-host "Found a file!"
  #      return
   #     }

Start-Sleep -seconds $slep

[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(3545,936)
Click-MouseButton
#$word1 = Get-RandomWord 2 3 
#$myshell.sendkeys("$word1")
Start-Sleep -seconds $slep

}
 
write-host "Timed out"
