export default function orderByOccurrence(arr) {
  let counts = {};
  arr.forEach(function(value){
    if(!counts[value]) {
      counts[value] = 0;
    }
    counts[value]++;
  });

  return Object.keys(counts).sort(function(curKey,nextKey) {
    return counts[curKey] < counts[nextKey];
  });
}
