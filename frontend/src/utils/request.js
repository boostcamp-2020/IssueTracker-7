const makeOptions = (method, body, header = null) => {
  const options = {
    method: method,
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
  };
  if (method != 'GET') {
    options.body = JSON.stringify(body);
  }
  if (header != null) {
    Object.assign(options.headers, header);
  }
  return options;
};

const request = async (method, url, body = {}, callback = null) => {
  const options = makeOptions(method, body);
  let status = null;
  if (callback) {
    fetch(url, options)
      .then((response) => {
        status = response.status;
        return response.json();
      })
      .then((response) => callback({ status, data: response }));
  } else {
    const response = await fetch(url, options);
    return { status: response.status, data: await response.json() };
  }
};

export { request };
