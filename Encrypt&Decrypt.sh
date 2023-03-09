#!/bin/bash

# Fungsi untuk mengenkripsi teks dengan algoritma Caesar cipher
function encrypt() {
  plaintext=$1
  shift=$2
  ciphertext=""

  for (( i=0; i<${#plaintext}; i++ )); do
    char=${plaintext:$i:1}
    ascii=$(printf "%d" "'$char")
    shifted_ascii=$((ascii+shift))
    if ((ascii>=65 && ascii<=90)); then
      if ((shifted_ascii>90)); then
        shifted_ascii=$((shifted_ascii-26))
      fi
    elif ((ascii>=97 && ascii<=122)); then
      if ((shifted_ascii>122)); then
        shifted_ascii=$((shifted_ascii-26))
      fi
    else
      shifted_ascii=$ascii
    fi
    shifted_char=$(printf \\$(printf '%03o' $shifted_ascii))
    ciphertext+=$shifted_char
  done

  echo $ciphertext
}

# Fungsi untuk mendekripsi teks dengan algoritma Caesar cipher
function decrypt() {
  ciphertext=$1
  shift=$2
  plaintext=""

  for (( i=0; i<${#ciphertext}; i++ )); do
    char=${ciphertext:$i:1}
    ascii=$(printf "%d" "'$char")
    shifted_ascii=$((ascii-shift))
    if ((ascii>=65 && ascii<=90)); then
      if ((shifted_ascii<65)); then
        shifted_ascii=$((shifted_ascii+26))
      fi
    elif ((ascii>=97 && ascii<=122)); then
      if ((shifted_ascii<97)); then
        shifted_ascii=$((shifted_ascii+26))
      fi
    else
      shifted_ascii=$ascii
    fi
    shifted_char=$(printf \\$(printf '%03o' $shifted_ascii))
    plaintext+=$shifted_char
  done

  echo $plaintext
}

# Meminta input dari pengguna
echo "Masukkan teks yang ingin dienkripsi:"
read plaintext
echo "Masukkan pergeseran (shift) yang ingin digunakan:"
read shift

# Memanggil fungsi enkripsi dan mencetak hasilnya
echo "Teks terenkripsi:"
encrypted=$(encrypt "$plaintext" $shift)
echo $encrypted

# Memanggil fungsi dekripsi dan mencetak hasilnya
echo "Teks terdekripsi:"
decrypted=$(decrypt "$encrypted" $shift)
echo $decrypted
