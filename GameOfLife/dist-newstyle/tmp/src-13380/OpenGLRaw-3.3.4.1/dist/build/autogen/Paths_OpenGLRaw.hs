{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_OpenGLRaw (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [3,3,4,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\cabal\\store\\ghc-8.10.7\\OpenGLRaw-3.3.4.1-c5786598a021cae40b6cff0cebd41485308a5c23\\bin"
libdir     = "C:\\cabal\\store\\ghc-8.10.7\\OpenGLRaw-3.3.4.1-c5786598a021cae40b6cff0cebd41485308a5c23\\lib"
dynlibdir  = "C:\\cabal\\store\\ghc-8.10.7\\OpenGLRaw-3.3.4.1-c5786598a021cae40b6cff0cebd41485308a5c23\\lib"
datadir    = "C:\\cabal\\store\\ghc-8.10.7\\OpenGLRaw-3.3.4.1-c5786598a021cae40b6cff0cebd41485308a5c23\\share"
libexecdir = "C:\\cabal\\store\\ghc-8.10.7\\OpenGLRaw-3.3.4.1-c5786598a021cae40b6cff0cebd41485308a5c23\\libexec"
sysconfdir = "C:\\cabal\\store\\ghc-8.10.7\\OpenGLRaw-3.3.4.1-c5786598a021cae40b6cff0cebd41485308a5c23\\etc"

getBinDir     = catchIO (getEnv "OpenGLRaw_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "OpenGLRaw_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "OpenGLRaw_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "OpenGLRaw_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "OpenGLRaw_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "OpenGLRaw_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
