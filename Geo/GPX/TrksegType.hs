module Geo.GPX.TrksegType where

import Geo.GPX.WptType
import Geo.GPX.ExtensionsType
import Text.XML.HXT.Arrow

data TrksegType = TrksegType [WptType] (Maybe ExtensionsType)
  deriving (Eq, Show)

trksegType :: [WptType] -> Maybe ExtensionsType -> TrksegType
trksegType = TrksegType

instance XmlPickler TrksegType where
  xpickle = xpWrap (\(trkpt, extensions) -> trksegType trkpt extensions, \(TrksegType trkpt extensions) -> (trkpt, extensions)) (xpPair
              (xpList (xpElem "trkpt" xpickle))
              (xpOption (xpElem "extensions" xpickle)))
