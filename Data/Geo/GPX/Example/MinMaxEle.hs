module Data.Geo.GPX.Example.MinMaxEle where

import Data.Geo.GPX
import Data.Maybe
import Control.Monad
import Text.XML.HXT.Arrow

-- Finds the minimum and maximum elevation (<ele>) in a list of GPX files (fails if no elevation).
minMaxEle :: [String] -> IO (Double, Double)
minMaxEle = fmap ((minimum &&& maximum) . (maybeToList . ele =<<) . (wpts . value =<<) . join) .
                 mapM (runX . xunpickleDocument (xpickle :: PU Gpx) [(a_remove_whitespace, v_1)])