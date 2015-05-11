# ig.drawPrecips!
ig.drawTemperatures!
return
years = ig.getYears!
container = d3.select ig.containers['correlator-leden-cerven']
correlator = new ig.MeteoCorrelator container
pranostiky = ig.pranostiky

pranostika = pranostiky."Chodí-li svatá Kateřina po ledě, chodí svatý Štěpán po blátě"
data = years
  .filter (.precips)
  .map (year) ->
    {yearNo, days} = year
    nextYearDays = year.nextYear?days
    id = yearNo
    [x, y] = pranostika.mapValues days, nextYearDays
    {yearNo, id, x, y}
  .filter -> !((isNaN it.x) || (isNaN it.y))

correlator.correlate data
# console.log pranostika.getConditions data
correlator.setConditions do
  pranostika.getConditions data
