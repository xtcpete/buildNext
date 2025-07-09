/**
 * Helper function to get the correct asset path for deployment
 * @param {string} path - The asset path (e.g., '/logo.png')
 * @returns {string} - The full path with base URL
 */
export function getAssetPath(path) {
  const baseUrl = import.meta.env.BASE_URL || '/';
  
  // If path already includes the base URL, return as-is
  if (path.startsWith(baseUrl)) {
    return path;
  }
  
  // Remove leading slash from path and ensure baseUrl ends with slash
  const cleanPath = path.replace(/^\//, '');
  const normalizedBaseUrl = baseUrl.endsWith('/') ? baseUrl : baseUrl + '/';
  return normalizedBaseUrl + cleanPath;
}
