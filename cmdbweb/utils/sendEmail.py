from django.core.mail import EmailMessage
from django.conf import settings

def send_email(subject, message, to, cc=None, from_email=None):
    """
    发送邮件,默认抄送给liangbingwen@comsenz-service.com.
    :param subject: 邮件主题
    :param message: 邮件内容
    :param to: 收件人(列表或元组)
    :param cc: 抄送地址(元组或列表)
    :param from_email: 发件人地址
    :return:
    """
    email = EmailMessage(
        subject=subject,
        body=message,
        to=to,
        cc=settings.DEFAULT_CC_EMAIL
    )
    return email
