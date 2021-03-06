{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances, MultiParamTypeClasses #-}

-- | Simple Type: @latitudeType@ <http://www.topografix.com/GPX/1/1/#type_latitudeType>
module Data.Geo.GPX.Type.Longitude(
  Longitude
, longitude
, runLongitude
) where

import Data.Fixed
import Text.XML.HXT.Arrow.Pickle
import Control.Newtype

newtype Longitude = Longitude Double
  deriving (Eq, Ord, Enum, Num, Fractional, Floating, Real, RealFrac, RealFloat)

longitude ::
  Double -- ^ The value which will be between -180 and 180 (values out of the range are truncated using a modulus operation).
  -> Longitude
longitude n =
  Longitude ((n + 180) `mod'` 360 - 180)

runLongitude ::
  Longitude
  -> Double
runLongitude (Longitude d) =
  d

instance Show Longitude where
  show (Longitude n) = show n

instance XmlPickler Longitude where
  xpickle = xpWrap (longitude, \(Longitude n) -> n) xpPrim

instance Newtype Longitude Double where
  pack = 
    longitude
  unpack (Longitude x) =
    x

