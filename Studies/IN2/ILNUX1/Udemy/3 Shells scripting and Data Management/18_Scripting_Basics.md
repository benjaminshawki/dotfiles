`#!bin/bash`

`chmod +x` makes a file executable

```shell
#!/bin/bash
echo "insert first number"
read first
echo "insert second number"
read second
if [ $first -eq $second ] 
        then
                echo "numbers are equal"
elif [ $first -gt $second ]
        then
                echo "first is greater then second"
else 
        echo "second is greater than second" 
fi
```

```shell
#!/bin/bash
for i in {1..10}
do
        echo $i
done
```

```shell
#!/bin/bash
for i in $( ls / )
do
        echo $i
done
```

```shell
#!/bin/bash
COUNT=6
while [ $COUNT -gt 0 ]; do
        echo Value of count is: $COUNT
        let COUNT=COUNT-1
done
```