const { getDefaultConfig } = require('expo/metro-config');

/** @type {import('expo/metro-config').MetroConfig} */
const config = getDefaultConfig(__dirname);

config.resolver = {
  ...config.resolver,
  sourceExts: ['jsx', 'js', 'ts', 'tsx', 'json'],
  assetExts: [...config.resolver.assetExts],
  platforms: ['ios', 'android', 'web'],
  unstable_enablePackageExports: false,
};

module.exports = config; 