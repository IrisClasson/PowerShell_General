$p = "the site"
$d =""
$f = "where to save file\" + "file name prefix"
$c = "class name"

for ($i=1; $i -le 101; $i++){
    Start-Job{ 
             $res = Invoke-WebRequest "$using:p$using:i.html"
             $html = $res.ParsedHtml
             $d = $html.getElementsByTagName('div') | ? { $_.className -eq $using:c }
             ($d).innerText | % { 
                $a = $_.Split("`r`n");
                $l = ('{0},{1}'-f $a[8],$a[10]);
                $l >> "$using:f$using:i.csv" 
                }
              $i++
        }
}

# Merging all files
# ls *prefix*.csv | % {gc $_ | % { $_ >> allNew.csv}}