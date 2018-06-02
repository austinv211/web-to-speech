<#
Name: TestScript.ps1
Description: Plays text to speech via powershell
Author: Austin Vargason
#>

#text to speech function
function start-TextToSpeech() {

    param (
        [Parameter(Mandatory=$true)]
        [String]$userString
    )

    #add-type speech
    Add-Type -AssemblyName System.speech

    $speachSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $speachSynth.Speak($userString)
}

function Get-WebText() {
    param(
        [Parameter(Mandatory=$true)]
        [String]$url
    )

    $data = Invoke-WebRequest -Uri $url

    $webText = $data.ParsedHTML.body.getElementsByTagName('p') | Select -ExpandProperty InnerText | Out-String

    return $webText
}

#get input for url
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$url = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a url", "URL", "https://en.wikipedia.org/wiki/Honda_Ridgeline")

start-TextToSpeech -userString (Get-WebText -url $url)