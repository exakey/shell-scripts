#!/usr/bin/env python3

import datetime

BIT_0 = "󰝣 "
BIT_1 = "󰝤 "

# BIT_0 = "."
# BIT_1 = "_"

def main():
    now = datetime.datetime.now()

    binary_now = list()
    for value in [now.hour, now.minute, now.second]:
        binary_now.append(f"{value:08b}".replace("0", BIT_0).replace("1", BIT_1))

    print(f"{binary_now[0]}\n{binary_now[1]}\n{binary_now[2]}")


if __name__ == "__main__":
    main()
