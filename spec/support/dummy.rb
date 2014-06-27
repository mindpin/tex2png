status = ARGV[0] == "dummy!" ? 0 : 444

$stderr.write "failed!\n" if status != 0

exit status
