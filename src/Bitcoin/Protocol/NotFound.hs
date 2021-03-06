module Bitcoin.Protocol.NotFound ( NotFound(..) ) where

import Control.Monad
import Control.Applicative
import Bitcoin.Protocol
import Bitcoin.Protocol.VarInt
import Bitcoin.Protocol.InvVector

data NotFound = NotFound {
   notFoundList :: [InvVector] 
} deriving (Eq, Read, Show)

instance BitcoinProtocol NotFound where

    bitcoinGet = NotFound <$> (repList =<< bitcoinGet)
        where repList (VarInt c) = replicateM (fromIntegral c) bitcoinGet

    bitcoinPut (NotFound xs) = do
        bitcoinPut $ lengthFromList xs
        forM_ xs bitcoinPut

