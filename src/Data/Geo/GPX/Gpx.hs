-- | Complex Type: @gpxType@ <http://www.topografix.com/GPX/1/1/#type_gpxType>
module Data.Geo.GPX.Gpx(
  Gpx
, gpx
) where

import Data.Geo.GPX.Metadata
import Data.Geo.GPX.Wpt
import Data.Geo.GPX.Rte
import Data.Geo.GPX.Trk
import Data.Geo.GPX.Extensions
import Data.Geo.GPX.Person
import Data.Geo.GPX.Lens.VersionL
import Data.Geo.GPX.Lens.CreatorL
import Data.Geo.GPX.Lens.MetadataL
import Data.Geo.GPX.Lens.WptsL
import Data.Geo.GPX.Lens.RtesL
import Data.Geo.GPX.Lens.TrksL
import Data.Geo.GPX.Lens.ExtensionsL
import Data.Lens.Common
import Control.Comonad.Trans.Store
import Text.XML.HXT.Arrow
import Text.XML.HXT.Extras
import Data.Maybe

data Gpx = Gpx String String (Maybe Metadata) [Wpt] [Rte] [Trk] (Maybe Extensions)
  deriving (Eq, Ord)

gpx ::
  String -- ^ The version.
  -> String -- ^ The creator.
  -> Maybe Metadata -- ^ The metadata.
  -> [Wpt] -- ^ The waypoints (wpt).
  -> [Rte] -- ^ The routes (rte).
  -> [Trk] -- ^ The tracks (trk).
  -> Maybe Extensions -- ^ The extensions.
  -> Gpx
gpx =
  Gpx

instance VersionL Gpx where
  versionL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> store (\version -> Gpx version creator metadata wpts rtes trks extensions) version

instance CreatorL Gpx where
  creatorL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> creator (\version -> Gpx version creator metadata wpts rtes trks extensions) creator

instance MetadataL Gpx where
  metadataL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> metadata (\version -> Gpx version creator metadata wpts rtes trks extensions) metadata

instance WptsL Gpx where
  wptsL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> wpts (\version -> Gpx version creator metadata wpts rtes trks extensions) wpts

instance RtesL Gpx where
  rtesL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> rtes (\version -> Gpx version creator metadata wpts rtes trks extensions) rtes

instance TrksL Gpx where
  trksL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> trks (\version -> Gpx version creator metadata wpts rtes trks extensions) trks

instance ExtensionsL Gpx where
  extensionsL =
    Lens $ \(Gpx version creator metadata wpts rtes trks extensions) -> extensions (\version -> Gpx version creator metadata wpts rtes trks extensions) extensions
