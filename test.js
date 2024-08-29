const awk = String.raw`awk '{print $1}'`;

awk`awk print $1`; // 'awk '{print $1}'print $1'
