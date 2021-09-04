alias g='git'

eval `git alias | awk '
function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}

{
  split($0,a," ");
  if (length(a) > 5) {
    print "alias g" a[1] "=\"git " a[1] "\""
  } else if (length(a) >= 3) {
    print "alias g" a[1] "=\"git " join(a, 3, length(a), " ", cmd) "\""
  }
}'`
