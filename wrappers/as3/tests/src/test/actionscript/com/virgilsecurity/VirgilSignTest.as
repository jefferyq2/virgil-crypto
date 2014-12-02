package com.virgilsecurity {

    import flash.utils.ByteArray;

    import org.hamcrest.*;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    import org.hamcrest.collection.*;

    import com.hurlant.util.Hex;

    import com.virgilsecurity.*;
    import com.virgilsecurity.wrapper.CModule;

    public class VirgilSignTest {
        private var sign_:VirgilSign;

        private static const TEST_HASH_NAME:String = "SHA512";
        private static const TEST_SIGNED_DIGEST:String = "SIGN DIGEST";
        private static const TEST_PUBLIC_KEY_PEM : String =
                "-----BEGIN PUBLIC KEY-----\n" +
                "MIGbMBQGByqGSM49AgEGCSskAwMCCAEBDQOBggAEa+CTMPBSOFoeZQIPiUOc84r2\n" +
                "BsdPwOzDshzW/JDeY85E8HC+cVF/9K+vdsoeyYP3yGpTwA53hZIKueUh+QAF53C9\n" +
                "X6uaP98Jiu8RMZNplo9p4BZpCwP90A2rxRSatEFHOOtw3FCCmHqzsxpEQCEwnd47\n" +
                "BOP7sd6Nwy37YlX95RM=\n" +
                "-----END PUBLIC KEY-----\n";

        [BeforeClass(description = "Init library")]
        public static function setup():void {
            CModule.startAsync();
        }

        [Before(description="Creates VirgilSign object and stores it in the 'sign_' variable.")]
        public function create_sign() : void {
            var signerCertificate:VirgilCertificate =
                    VirgilCertificate.create(ConvertionUtils.asciiStringToArray(TEST_PUBLIC_KEY_PEM));
            sign_ = VirgilSign.create(signerCertificate,
                    ConvertionUtils.asciiStringToArray(TEST_HASH_NAME),
                    ConvertionUtils.asciiStringToArray(TEST_SIGNED_DIGEST)
                );
            assertThat(sign_.cPtr, not(equalTo(0)));
        }

        [After(description="Destroy VirgilSign object stored it in the 'sign_' variable.")]
        public function destroy_sign() : void {
            sign_.destroy();
            sign_ = null;
        }

        [Test(description="Test VirgilSign 'id' accessors.")]
        public function test_sign_id():void {
            assertThat(sign_.id().accountId().length, equalTo(0));
            assertThat(sign_.id().certificateId().length, equalTo(0));
            assertThat(sign_.id().ticketId().length, equalTo(0));
            assertThat(sign_.id().signId().length, equalTo(0));

            var id:VirgilSignId = VirgilSignId.create();
            id.setAccountId(ConvertionUtils.asciiStringToArray("123"));
            id.setCertificateId(ConvertionUtils.asciiStringToArray("456"));
            id.setTicketId(ConvertionUtils.asciiStringToArray("789"));
            id.setSignId(ConvertionUtils.asciiStringToArray("000"));
            sign_.setId(id);
            id.destroy();

            assertThat(sign_.id().accountId().length, not(equalTo(0)));
            assertThat(sign_.id().certificateId().length, not(equalTo(0)));
            assertThat(sign_.id().ticketId().length, not(equalTo(0)));
            assertThat(sign_.id().signId().length, not(equalTo(0)));

            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().accountId()), equalTo("123"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().certificateId()), equalTo("456"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().ticketId()), equalTo("789"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().signId()), equalTo("000"));
        }

        [Test(description="Test VirgilSignId 'id' accessor is mutable")]
        public function test_sign_id_mutable():void {
            assertThat(sign_.id().accountId().length, equalTo(0));
            assertThat(sign_.id().certificateId().length, equalTo(0));
            assertThat(sign_.id().ticketId().length, equalTo(0));
            assertThat(sign_.id().signId().length, equalTo(0));

            sign_.id().setAccountId(ConvertionUtils.asciiStringToArray("123"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().accountId()), equalTo("123"));

            sign_.id().setCertificateId(ConvertionUtils.asciiStringToArray("456"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().certificateId()), equalTo("456"));

            sign_.id().setTicketId(ConvertionUtils.asciiStringToArray("789"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().ticketId()), equalTo("789"));

            sign_.id().setSignId(ConvertionUtils.asciiStringToArray("000"));
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.id().signId()), equalTo("000"));
        }

        [Test(description="Test VirgilSign::signerCertificate() returns the same object.")]
        public function test_sign_signerCertificate_is_same():void {
            assertThat(sign_.signerCertificate().cPtr, equalTo(sign_.signerCertificate().cPtr));
        }

        [Test(description="Test VirgilSign::signerCertificate().")]
        public function test_sign_signerCertificate():void {
            assertThat(ConvertionUtils.arrayToAsciiString(sign_.signerCertificate().publicKey()),
                    equalTo(TEST_PUBLIC_KEY_PEM));
        }
    }

}