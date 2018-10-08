$nr = 1

Dir | %{Rename-Item $_ -NewName (‘MyFile{0}.txt’ -f $nr++)}