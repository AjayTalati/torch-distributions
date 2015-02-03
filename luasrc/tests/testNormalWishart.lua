require 'totem'
require 'distributions'
require 'torch'
require 'pl.strict'

local myTests = {}
local tester = totem.Tester()
torch.manualSeed(1234567890)

function myTests.testNormalWishartRnd()
  local D = 5
  local loc = torch.randn(D)
  local beta = 10
  local nu = D + 10
  local V = torch.randn(D,D)
  V = V * V:t()

  tester:assert(distributions.nw.rnd(loc, beta, V, nu))
end

function myTests.testNormalWishartPdf()
  local D = 5
  local loc = torch.randn(D)
  local beta = 10
  local nu = D + 10
  local V = torch.randn(D,D)
  V = V * V:t()

  local mean = torch.randn(D)
  local prec = torch.randn(D,D)
  prec = prec * prec:t()

  tester:assert(distributions.nw.pdf(mean, prec, loc, beta, V, nu))
  tester:assert(distributions.nw.logpdf(mean, prec, loc, beta, V, nu))
end

tester:add(myTests)
return tester:run()