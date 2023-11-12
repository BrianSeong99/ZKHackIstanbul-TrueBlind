export function stringToBigInt(input) {
    const encoder = new TextEncoder();
    const encodedBytes = encoder.encode(input);
  
    let bigIntValue = BigInt(0);
    for (let i = 0; i < encodedBytes.length; i++) {
      const byteValue = BigInt(encodedBytes[i]);
      const shiftedValue = byteValue << BigInt(8 * i);
      bigIntValue = bigIntValue | shiftedValue;
    }
  
    return bigIntValue;
  }
  
  export function bigIntToString(bigIntValue) {
    const bytes = [];
    let tempBigInt = bigIntValue;
  
    while (tempBigInt > BigInt(0)) {
      const byteValue = Number(tempBigInt & BigInt(255));
      bytes.push(byteValue);
      tempBigInt = tempBigInt >> BigInt(8);
    }
  
    const decoder = new TextDecoder();
    const asciiString = decoder.decode(Uint8Array.from(bytes));
    return asciiString;
  }

export function splitStringToBigInts(input) {
    const chunkSize = 16; // Chunk size to split the string
    const numChunks = Math.ceil(input.length / chunkSize);
    const bigInts = [];
  
    for (let i = 0; i < numChunks; i++) {
      const chunk = input.substr(i * chunkSize, chunkSize);
      const bigIntValue = stringToBigInt(chunk);
      bigInts.push(bigIntValue);
    }
  
    return bigInts;
  }
  
  export function joinBigIntsToString(bigInts) {
    let result = '';
  
    for (let i = 0; i < bigInts.length; i++) {
      const chunkString = bigIntToString(bigInts[i]);
      result += chunkString;
    }
  
    return result;
  }