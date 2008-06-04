function emailForm(to_person){

  if(to_person=='walker'){
    addy = 'jrw@jrwalker.com';
  }

  var subject = "AA Rose Construction Website Request";
  var body_message = "";

  var mailto_link = 'mailto:'+addy+'?subject='+subject+'&body='+body_message;

  win = window.open(mailto_link,'emailWindow');
  if (win && win.open &&!win.closed) win.close();
}
